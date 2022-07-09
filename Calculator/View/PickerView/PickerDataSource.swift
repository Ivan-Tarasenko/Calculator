//
//  PickerDataSource.swift
//  Calculator
//
//  Created by Иван Тарасенко on 06.07.2022.
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource {

    var currency: [String: Currency] = [:]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}

extension PickerDataSource: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var title = [String]()
        var subtitle = [String]()
        let sortCurrency = currency.sorted(by: {$0.key < $1.key})

        for (key, value) in sortCurrency {
            title.append(key)
            subtitle.append(value.name)
        }

        return ItemView.create(title: title[row], subtitle: subtitle[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.isHidden = true
    }
}
