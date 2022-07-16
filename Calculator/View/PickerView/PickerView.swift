//
//  PickerView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 04.07.2022.
//

import UIKit

final class PickerView: UIPickerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColor(dark: availableColor(), light: .white, defaultColor: .white)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func availableColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray6
        } else {
            return .white
        }
    }
}
