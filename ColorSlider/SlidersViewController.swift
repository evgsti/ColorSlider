import UIKit

final class SlidersViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabelValue: UILabel!
    @IBOutlet var greenLabelValue: UILabel!
    @IBOutlet var blueLabelValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    weak var delegate: SlidersViewControllerDelegate?
    
    // MARK: - Public Properties
    var backgroundColor: UIColor!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = backgroundColor
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        updateSliders()
        updateLabels()
        updateTextFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redLabelValue.text = formattedValue(redSlider.value)
            redTextField.text = formattedValue(redSlider.value)
        case greenSlider:
            greenLabelValue.text = formattedValue(greenSlider.value)
            greenTextField.text = formattedValue(greenSlider.value)
        default:
            blueLabelValue.text = formattedValue(blueSlider.value)
            blueTextField.text = formattedValue(blueSlider.value)
        }
        updateColorView()
    }
    
    @IBAction func doneButtonAction() {
        delegate?.changeColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func updateSliders() {
        let ciColor = CIColor(color: backgroundColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }

    private func updateLabels() {
        redLabelValue.text = formattedValue(redSlider.value)
        greenLabelValue.text = formattedValue(greenSlider.value)
        blueLabelValue.text = formattedValue(blueSlider.value)
    }
    
    private func updateTextFields() {
        redTextField.text = formattedValue(redSlider.value)
        greenTextField.text = formattedValue(greenSlider.value)
        blueTextField.text = formattedValue(blueSlider.value)
    }
    
    private func updateColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func formattedValue(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    private func showErrorAlert(
        withTitle title: String,
        andMessage message: String,
        textField: UITextField?
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) {_ in
            textField?.becomeFirstResponder()
            textField?.text = "0.5"
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SlidersViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text,
              let textFieldValue = Float(value),
              (0...1).contains(textFieldValue) else {
            showErrorAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        let textFieldToSlider: [UITextField: UISlider] = [
            redTextField: redSlider,
            greenTextField: greenSlider,
            blueTextField: blueSlider
        ]
        
        let textFieldToLabel: [UITextField: UILabel] = [
            redTextField: redLabelValue,
            greenTextField: greenLabelValue,
            blueTextField: blueLabelValue
        ]
        
        if let slider = textFieldToSlider[textField], 
            let label = textFieldToLabel[textField] {
            slider.setValue(textFieldValue, animated: true)
            label.text = formattedValue(textFieldValue)
        }
        
        updateColorView()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem:UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(self.doneButtonTapped) )
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
