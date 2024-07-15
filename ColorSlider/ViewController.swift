//
//  ViewController.swift
//  ColorSlider
//
//  Created by Евгений on 15.07.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabelValue: UILabel!
    @IBOutlet var greenLabelValue: UILabel!
    @IBOutlet var blueLabelValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Private Properties
    private var redValue: Float = 0.05
    private var greenValue: Float = 0.27
    private var blueValue: Float = 0.49
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        defaultSliderSetup()
        sliderValueToLabels()
        colorViewBackgroundChange()
    }

    // MARK: - IB Actions
    @IBAction func sliderAction() {
        redValue = redSlider.value
        greenValue = greenSlider.value
        blueValue = blueSlider.value
        
        sliderValueToLabels()
        colorViewBackgroundChange()
    }
    
    // MARK: - Private Methods
    private func defaultSliderSetup() {
        redSlider.value = redValue
        greenSlider.value = greenValue
        blueSlider.value = blueValue
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func sliderValueToLabels() {
        redLabelValue.text = String(format: "%.2f", redValue)
        greenLabelValue.text = String(format: "%.2f", greenValue)
        blueLabelValue.text = String(format: "%.2f", blueValue)
    }
    
    private func colorViewBackgroundChange() {
        colorView.backgroundColor = UIColor.init(
            red: CGFloat(redValue),
            green: CGFloat(greenValue),
            blue: CGFloat(blueValue),
            alpha: 1
        )
    }
}

