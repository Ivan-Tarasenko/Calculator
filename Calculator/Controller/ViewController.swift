//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!

    var networkManager = NetworkManager()
    let model = ViewModel()

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
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

// MARK: - Actions
    @IBAction func numberPrassed(_ sender: UIButton) {
        model.restrictDigitInput(
            inputDigit: sender.currentTitle!,
            output: displayResultLabel
        )
    }

    @IBAction func twoOperandSingPressed(_ sender: UIButton) {
        model.saveFirstОperand(
            operation: sender.currentTitle!,
            currentInput: currentInput
        )
    } 

    @IBAction func equalitySingPressed(_ sender: UIButton) {
        model.performOperation(currentInput: &currentInput)
    }

    @IBAction func clear(_ sender: UIButton) {
        model.clear(currentInput: &currentInput, uotputLabel: displayResultLabel)
    }

    @IBAction func plusMinusPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func procentPressed(_ sender: UIButton) {
        model.calculatePercentage(currentInput: &currentInput)
    }

    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }

    @IBAction func dotButtonPressed(_ sender: UIButton) {
        model.enterNumberWithDot(outputLabel: displayResultLabel)
    }

    @IBAction func convertFromDollarToRuble(_ sender: UIButton) {
        var currentName = ""
        switch sender.currentTitle! {
        case "＄/₽":
            currentName = "USD"
        default:
            currentName = "EUR"
        }
        
        model.currencyConversion(
            name: currentName,
            quantity: currentInput,
            outputLabel: displayResultLabel
        )
    }
}
