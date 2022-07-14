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
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .systemGray6
                default:
                    return .white
                }
            }
        } else {
            backgroundColor = .white
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
