//
//  ColorViewController.swift
//  ColorSlider
//
//  Created by Евгений on 07.08.2024.
//

import UIKit

protocol SlidersViewControllerDelegate: AnyObject {
    func changeColor(for background: UIColor)
}

final class ColorViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let slidersVC = segue.destination as? SlidersViewController
        
        slidersVC?.delegate = self
        slidersVC?.backgroundColor = view.backgroundColor
    }
}

// MARK: - SlidersViewControllerDelegate
extension ColorViewController: SlidersViewControllerDelegate {
    func changeColor(for background: UIColor) {
        view.backgroundColor = background
    }
}
