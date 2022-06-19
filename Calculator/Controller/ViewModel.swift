//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ViewModel {

    var networkManager = NetworkManager()

    var stillTyping = true
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var resultProcent: Double = 0
    var opiretionSing: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.txt)!
        }
        set {
            let value = "\(newValue)"
            let valueArrey = value.components(separatedBy: ".")
            if valueArrey[1] == "0" {
                displayResultLabel.txt = "\(valueArrey[0])"
            } else {
                displayResultLabel.txt = "\(newValue)"
            }

            stillTyping = true
        }
    }


    




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

    func currencyConversion(name: String, quantity: Double, outputLabel: UILabel) {
        var currencyValue: Double = 0.0
        networkManager.fetctData { currencyEntity in
            for (key, value) in currencyEntity.rates where key == name {
                currencyValue = value
            }
            DispatchQueue.main.sync {
                let result = quantity / currencyValue
                let rounderValue = round(result * 100) / 100
                outputLabel.txt = String(rounderValue)
            }
        }
    }

    enum Currencys {
        case aud
        case azn
        case gbp
        case amd
        case byn
        case bgn
        case brl
        case huf
        case hkd
        case dkk
        case usd
        case eur
        case inr
        case kzt
        case cad
        case kgs
        case cny
        case mdl
        case nok
        case pln
        case ron
        case xdr
        case sgd
        case tjs
        case tur
        case tmt
        case uzs
        case uah
        case czk
        case sek
        case chf
        case zar
        case krw
        case jpy
    }

}
