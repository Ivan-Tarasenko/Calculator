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

    var isTyping = false
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var opiretionSing: String = ""

    func restrictDigitInput(inputDigit: String, output label: UILabel) {
        if isTyping {
            if label.txt.count < 20 {
                label.txt += inputDigit
            }
        } else {
            label.txt = inputDigit
            isTyping = true
        }

        if label.txt == "0" {
            isTyping = false
        }
    }

    func saveFirstОperand(operation: String, currentInput: Double) {
        opiretionSing = operation
        firstOperand = currentInput
        isTyping = false
        dotIsPlased = false
    }

    func performOperation(currentInput: inout Double) {

        func resultOperation(operation: (Double, Double) -> Double) {
                currentInput = operation(firstOperand, secondOperand)
                isTyping = true
            }

        if isTyping {
            secondOperand = currentInput
        }

        switch opiretionSing {
        case "+":
            resultOperation {$0 + $1}
        case "-":
            resultOperation {$0 - $1}
        case "×":
            resultOperation {$0 * $1}
        case "÷":
            resultOperation {$0 / $1}
        default:
            break
        }

        if currentInput < firstOperand {
            isTyping = false
            firstOperand = currentInput
        }
    }

    func calculatePercentage(currentInput: inout Double) {
        if firstOperand == 0 {
            currentInput /= 100
        }
        switch opiretionSing {
        case "+":
            currentInput = firstOperand + ((firstOperand / 100) * currentInput)
        case "-":
            currentInput = firstOperand - ((firstOperand / 100) * currentInput)
        case "×":
            currentInput = (firstOperand / 100) * currentInput
        case "÷":
            currentInput = (firstOperand / currentInput) * 100
        default:
            break
        }
    }

    func enterNumberWithDot(outputLabel: UILabel) {
        if isTyping && !dotIsPlased {
            outputLabel.txt  += "."
        } else if !isTyping && !dotIsPlased {
            outputLabel.txt = "0."
            isTyping = true
        }
    }

    func clear(currentInput: inout Double, uotputLabel: UILabel) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        uotputLabel.txt = "0"
        opiretionSing = ""
        isTyping = false
        dotIsPlased = false
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
