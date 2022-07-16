//
//  UIView+SetColor.swift
//  Calculator
//
//  Created by Иван Тарасенко on 14.07.2022.
//

import UIKit

extension UIView {

    func setupColor(dark: UIColor, light: UIColor, defaultColor: UIColor) {
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return dark
                default:
                    return light
                }
            }
        } else {
            backgroundColor = defaultColor
        }
    }
}
