//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ViewModel {

    let saveData = SaveData()

    var isTyping = false
    var isDotPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation: String = ""
    var dateFromData: String?
    let currentDate = NSDate()

    var onUpDataCurrency: (([String: Currency]) -> Void)?

    var currency: [String: Currency]? {
        didSet {
            if let currency = currency {
                onUpDataCurrency?(currency)
            }
        }
    }

    var abbreviatedDate: String? {
        var abbriviatedData: String?
        if let dateFromData = dateFromData {
            let dateArray = dateFromData.components(separatedBy: "T")
            abbriviatedData = dateArray[0]
        }
        return abbriviatedData
    }

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
            isDotPlased = true
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

    // MARK: - Fetch data
    func fetctData(completion: @escaping (Bool) -> Void) {
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        let URL = URL(string: urlString)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: URL!) { data, _, error in
            if error != nil {
                if let currencyEntity =  self.parseJSON(withData: self.saveData.data!) {
                    DispatchQueue.main.async {
                        self.dateFromData = currencyEntity.date
                        self.currency = currencyEntity.currency
                        completion(false)
                    }
                }
            }
            if let data = data {
                self.saveData.data = data
                if let currencyEntity =  self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        self.dateFromData = currencyEntity.date
                        self.currency = currencyEntity.currency
                        completion(true)
                    }
                }
            }
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> CurrencyEntity? {
        let decoder = JSONDecoder()
        do {
            let currentDate = try decoder.decode(CurrentData.self, from: data)
            guard let currencyEntity = CurrencyEntity(currencyEntity: currentDate) else { return nil }
            return currencyEntity
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

    func getCurrencyExchange(for charCode: String, quantity: Double) -> String {
        guard let valute = currency else { return "0" }
        let currency = valute[charCode]
        let currencyValue = currency?.value
        let naminal = currency?.nominal
        let result = (currencyValue! / naminal!) * quantity
        let roundValue = round(result * 1000) / 1000
        isTyping = false

        return String(roundValue)
    }

    func currencyKeys() -> [String] {
        var keys = [String]()
        if let currency = currency {
            let sortCurrency = currency.sorted(by: {$0.key < $1.key})
            for (key, _) in sortCurrency {
                keys.append(key)
            }
        }
        return keys
    }

    func currencyName() -> [String] {
        var names = [String]()
        if let currency = currency {
            let sortCurrency = currency.sorted(by: {$0.key < $1.key})
            for (_, value) in sortCurrency {
                names.append(value.name)
            }
        }
        return names
    }

    func colculateCrossRate(firstOperand: Double, secondOperand: Double) -> String {
        let result = firstOperand / secondOperand
        let roundValue = round(result * 1000) / 1000
        isTyping = false
        return String(roundValue)
    }

}
