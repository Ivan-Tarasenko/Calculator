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
        model.doNotEnterZeroFirst(for: displayResultLabel)
        model.limitInput(for: sender.currentTitle!, andshowIn: displayResultLabel)
    }

    @IBAction func twoOperandSingPressed(_ sender: UIButton) {
        model.saveFirstОperand(from: currentInput)
        model.saveOperation(from: sender.currentTitle!)
    } 

    @IBAction func equalitySingPressed(_ sender: UIButton) {
        model.performOperation(for: &currentInput)
    }

    @IBAction func plusMinusPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func procentPressed(_ sender: UIButton) {
        model.calculatePercentage(for: &currentInput)
    }

    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }

    @IBAction func dotButtonPressed(_ sender: UIButton) {
        model.enterNumberWithDot(in: displayResultLabel)
    }

    @IBAction func clear(_ sender: UIButton) {
        model.clear(&currentInput, and: displayResultLabel)
    }

    @IBAction func convertFromDollarToRuble(_ sender: UIButton) {
        var currencyCode = ""
        switch sender.currentTitle! {
        case "＄/₽":
            currencyCode = "USD"
        default:
            currencyCode = "EUR"
        }
        
        model.getCurrencyExchange(
            for: currencyCode,
            quantity: currentInput,
               andShowIn: displayResultLabel
        )
    }
}
