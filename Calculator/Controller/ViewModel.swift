//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ViewModel {

    var network = NetworkManager()

    var isTyping = false
    var isDotPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation: String = ""

    func limitInput(for inputValue: String, andshowIn label: UILabel) {
        if isTyping {
            if label.txt.count < 20 {
                label.txt += inputValue
            }
        } else {
            label.txt = inputValue
            isTyping = true
        }
    }

    func doNotEnterZeroFirst(for label: UILabel) {
        if label.txt == "0" {
            isTyping = false
        }
    }

    func saveFirstОperand(from currentInput: Double) {
        firstOperand = currentInput
        isTyping = false
        isDotPlased = false
    }

    func saveOperation(from currentOperation: String) {
        operation = currentOperation
    }

    func performOperation(for value: inout Double) {

        func performingAnOperation(with operand: (Double, Double) -> Double) {
                value = operand(firstOperand, secondOperand)
                isTyping = true
            }

        if isTyping {
            secondOperand = value
        }

        switch operation {
        case "+":
            performingAnOperation {$0 + $1}
        case "-":
            performingAnOperation {$0 - $1}
        case "×":
            performingAnOperation {$0 * $1}
        case "÷":
            performingAnOperation {$0 / $1}
        default:
            break
        }

        if value < firstOperand {
            isTyping = false
            firstOperand = value
        }

    }

    func calculatePercentage(for value: inout Double) {
        if firstOperand == 0 {
            value /= 100
        }
        switch operation {
        case "+":
            value = firstOperand + ((firstOperand / 100) * value)
        case "-":
            value = firstOperand - ((firstOperand / 100) * value)
        case "×":
            value = (firstOperand / 100) * value
        case "÷":
            value = (firstOperand / value) * 100
        default:
            break
        }
    }

    func enterNumberWithDot(in label: UILabel) {
        if isTyping && !isDotPlased {
            label.txt  += "."
        } else if !isTyping && !isDotPlased {
            label.txt = "0."
            isTyping = true
        }
    }

    func clear(_ currentValue: inout Double, and label: UILabel) {
        firstOperand = 0
        secondOperand = 0
        currentValue = 0
        label.txt = "0"
        operation = ""
        isTyping = false
        isDotPlased = false
    }

    func getCurrencyExchange(for name: String, quantity: Double, andShowIn label: UILabel) {
        var currencyValue: Double = 0.0
        network.fetctData { currencyEntity in
            for (key, value) in currencyEntity.rates where key == name {
                currencyValue = value
            }
            DispatchQueue.main.sync {
                let result = quantity / currencyValue
                let rounderValue = round(result * 100) / 100
                label.txt = String(rounderValue)
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
