//
//  PickerDataSource.swift
//  Calculator
//
//  Created by Иван Тарасенко on 06.07.2022.
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource {

    var viewModel = ViewModel()
    var object: CurrencyEntity? = nil

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

extension PickerDataSource: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = ""
        var titles = [String]()

        if let currency = viewModel.currency {
            for (_, value) in currency {
                titles.append(value.name)
            }
        } else {
            print("nil")
        }

        print(titles)
        return title
    }
    
}
