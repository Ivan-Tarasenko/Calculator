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
    let model = ModelCalc()

    var stillTyping = true
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var resultProcent: Double = 0
    var opiretionSing: String = ""
    var currentInput: Double {
        get {
            return  Double(displayResultLabel.text!)!
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

    var dollar: Double = 0
    var currencys = ModelCalc.Currencys.aud
//    var currencyName = ""

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
//        networkManager.fetctData()
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

        switch sender.currentTitle! {
        case "＄/₽":
            currencys = .usd
        case "€/₽":
            currencys = .eur
        default:
            break
        }

        networkManager.fetctData { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                let result = self.currentInput / self.dollar
                let rounderValue = round(result * 100) / 100
                self.displayResultLabel.txt = String(rounderValue)
            }
        }
    }
}

extension ViewController: NetworkManagerDelegate {
    func dataRaceived(_: NetworkManager, with currentCurrency: CurrentCurrency) {
        var currencyName = ""

        switch currencys {
        case .aud:
            currencyName = "AUD"
        case .azn:
            currencyName = "AZN"
        case .gbp:
            currencyName = "GBP"
        case .amd:
            currencyName = "AMD"
        case .byn:
            currencyName = "BYN"
        case .bgn:
            currencyName = "BGN"
        case .brl:
            currencyName = "BRL"
        case .huf:
            currencyName = "HUF"
        case .hkd:
            currencyName = "HKD"
        case .dkk:
            currencyName = "DKK"
        case .usd:
            currencyName = "USD"
        case .eur:
            currencyName = "EUR"
        case .inr:
            currencyName = "INR"
        case .kzt:
            currencyName = "KZT"
        case .cad:
            currencyName = "CAD"
        case .kgs:
            currencyName = "KGS"
        case .cny:
            currencyName = "CNY"
        case .mdl:
            currencyName = "MDL"
        case .nok:
            currencyName = "NOK"
        case .pln:
            currencyName = "PLN"
        case .ron:
            currencyName = "RON"
        case .xdr:
            currencyName = "XDR"
        case .sgd:
            currencyName = "SGD"
        case .tjs:
            currencyName = "TJS"
        case .tur:
            currencyName = "TRY"
        case .tmt:
            currencyName = "TMT"
        case .uzs:
            currencyName = "UZS"
        case .uah:
            currencyName = "UAH"
        case .czk:
            currencyName = "CZK"
        case .sek:
            currencyName = "SEK"
        case .chf:
            currencyName = "CHF"
        case .zar:
            currencyName = "ZAR"
        case .krw:
            currencyName = "KRW"
        case .jpy:
            currencyName = "JPY"
        }
        for (key, value) in currentCurrency.rates where key == currencyName {
            dollar = value
        }
    }
}
