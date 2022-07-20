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
    var valueOfFirstCurrency: Double = 0
    var valueOfSecondCurrency: Double = 0
    var firstTitle: String = ""
    var secondTitle: String = ""

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
        let item = ItemView.create(
            title: title[row],
            subtitle: subtitle[row],
            wightItem: Int(pickerView.bounds.width)
        )
        
        return item
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let key = title[row]

        switch component {
        case 0:
            firstTitle = key
            valueOfFirstCurrency = currency[key]!.value / currency[key]!.nominal
        case 1:
            secondTitle = key
            valueOfSecondCurrency = currency[key]!.value / currency[key]!.nominal
        default:
            break
        }
    }
}
