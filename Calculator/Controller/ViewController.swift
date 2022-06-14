//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!

    var network = NetworkManager()
    let model = ModelCalc()

    var stillTyping = true
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var resultProcent: Double = 0
    var opiretionSing: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //    Actions
    //    Buttons with numbers
    @IBAction func numberPrassed(_ sender: UIButton) {

        let number = sender.currentTitle!

        if stillTyping {
            displayResultLabel.txt = number
            stillTyping = false
        } else {
            if displayResultLabel.txt.count < 20 {
                displayResultLabel.txt  += number
            }
        }
    }

    //    Buttons with mathematical operators
    @IBAction func twoOperandSingPressed(_ sender: UIButton) {
        opiretionSing = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = true
        dotIsPlased = false

    }

    func resultOperation(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = true
    }

    //    Equal button
    @IBAction func result(_ sender: UIButton) {

        if !stillTyping {
            secondOperand = currentInput
        }

        dotIsPlased = false

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
    }

    //    Cleaning button
    @IBAction func clear(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.txt = "0"
        opiretionSing = ""
        stillTyping = true
        dotIsPlased = false
    }

    //    Minus button for the number
    @IBAction func plusMinusPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    //    Percent button
    @IBAction func procentPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput /= 100
        }
        switch opiretionSing {
        case "+":
            resultProcent = firstOperand + ((firstOperand / 100) * currentInput)
        case "-":
            resultProcent = firstOperand - ((firstOperand / 100) * currentInput)
        case "×":
            resultProcent = (firstOperand / 100) * currentInput
        case "÷":
            resultProcent = (firstOperand / currentInput) * 100
        default:
            break
        }
        let valueString = String(resultProcent)
        let valueArrayProcent = valueString.components(separatedBy: ".")
        if valueArrayProcent[1] == "0" {
            displayResultLabel.txt = "\(valueArrayProcent[0])"
        } else {
            displayResultLabel.txt = String(resultProcent)
        }
    }

    //    Square Root button
    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }

    //    Point button
    @IBAction func dotButtonPressed(_ sender: UIButton) {

        if !stillTyping && !dotIsPlased {
            displayResultLabel.txt  += "."
        } else if stillTyping && !dotIsPlased {
            displayResultLabel.txt = "0."
            stillTyping = false
        }
    }
    //    Dollar Conversion button
    @IBAction func convertFromDollarToRuble(_ sender: UIButton) {
        model.dollarVSRuble(label: displayResultLabel)
//        network.fetctData()
//        network.onComplition = { currentCurrency in
//            print(currentCurrency.date)
//            for (key, value) in currentCurrency.rates where key == "USD" {
//
//                DispatchQueue.main.sync {
//                    self.displayResultLabel.txt = "\(value)"
//                }
//
//            }
//        }
    }
}
