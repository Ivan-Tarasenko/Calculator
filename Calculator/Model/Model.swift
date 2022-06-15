//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ModelCalc {

    var networkManager = NetworkManager()

    func inputRestriction(symbol: String, output label: UILabel, typing: inout Bool) {
        if typing {
            label.txt = symbol
            typing = false
        } else {
            if label.txt.count < 20 {
                label.txt  += symbol
            }
        }
    }

    func dollarVSRuble(label: UILabel) {

        networkManager.fetctData()
        networkManager.onComplition = { currentCurrency in

            for (key, value) in currentCurrency.rates where key == "USD" {

                DispatchQueue.main.sync {
                    label.txt = String(value)
                }

            }

        }
        
    }
}
