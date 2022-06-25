//
//  UILabel+SafeText.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import UIKit

extension UILabel {

    var txt: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }
}
