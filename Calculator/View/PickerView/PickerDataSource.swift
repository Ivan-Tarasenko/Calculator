//
//  PickerDataSource.swift
//  Calculator
//
//  Created by Иван Тарасенко on 06.07.2022.
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource {

    let viewModel = ViewModel()

    var currency: [String: Currency] = [:]
    var title = [String]()
    var subtitle = [String]()
    var firstValue: Double = 0
    var secondValue: Double = 0
    var firstTitle: String = ""
    var secondTitle: String = ""

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        setValueOfFirstItems()
        return currency.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}

extension PickerDataSource: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return ItemView.create(title: title[row], subtitle: subtitle[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            let key = title[row]
            firstTitle = key
            firstValue = currency[key]!.value / currency[key]!.nominal
        case 1:
            let key = title[row]
            secondTitle = key
            secondValue = currency[key]!.value / currency[key]!.nominal
        default:
            break
        }
    }

    func setValueOfFirstItems() {
        firstValue = currency[title[0]]!.value / currency[title[0]]!.nominal
        secondValue = currency[title[0]]!.value / currency[title[0]]!.nominal
        firstTitle = title[0]
        secondTitle = title[0]
    }
}
