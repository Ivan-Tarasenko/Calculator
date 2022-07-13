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
        backgroundColor = .white

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
