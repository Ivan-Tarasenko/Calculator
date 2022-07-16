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
    var isDotPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation: String = ""
    var dateFromData: String?

    var onUpDataCurrency: (([String: Currency]) -> Void)?
    var currencies: [String: Currency]? {
        didSet {
            if let currency = currencies {
                onUpDataCurrency?(currency)
            }
        }
    }

    var abbreviatedDate: String? {
        var abbreviatedData: String?
        if let dateFromData = dateFromData {
            let dateArray = dateFromData.components(separatedBy: "T")
            abbreviatedData = dateArray[0]
        }
        return abbreviatedData
    }

    func limitInput(for inputValue: String, andShowIn label: UILabel) {
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
        isDotPlaced = false
    }

    func saveOperation(from currentOperation: String) {
        operation = currentOperation
    }

    func performOperation(for value: inout Double) {

        func performingAnOperation(with operand: (Double, Double) -> Double) {
            value = operand(firstOperand, secondOperand)
            isTyping = false
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
            firstOperand = value
        } else {
            secondOperand = value
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
        if isTyping && !isDotPlaced {
            label.txt  += "."
            isDotPlaced = true
        } else if !isTyping && !isDotPlaced {
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
        isDotPlaced = false
    }

    // MARK: - Fetch data
    func fetchData(completion: @escaping (Bool) -> Void) {
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        guard let URL = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: URL) { data, _, error in
            if error != nil {
                if let data = self.saveData.data {
                    if let currencyEntity =  self.parseJSON(withData: data) {
                        DispatchQueue.main.async {
                            self.dateFromData = currencyEntity.date
                            self.currencies = currencyEntity.currency
                            completion(false)
                        }
                    }
                }
            }
            if let data = data {
                self.saveData.data = data
                if let currencyEntity =  self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        self.dateFromData = currencyEntity.date
                        self.currencies = currencyEntity.currency
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

    func currencyKeys() -> [String] {
        var keys = [String]()
        if let currency = currencies {
            let sortCurrency = currency.sorted(by: {$0.key < $1.key})
            for (key, _) in sortCurrency {
                keys.append(key)
            }
        }
        return keys
    }

    func currencyName() -> [String] {
        var names = [String]()
        if let currency = currencies {
            let sortCurrency = currency.sorted(by: {$0.key < $1.key})
            for (_, value) in sortCurrency {
                names.append(value.name)
            }
        }
        return names
    }

    func getCurrencyExchange(for charCode: String, quantity: Double) -> String {
        guard let currencies = currencies else { return "0" }
        var quantity = quantity
        if quantity == 0 {
            quantity = 1
        }
        let currency = currencies[charCode]
        let currencyValue = currency?.value
        let naminal = currency?.nominal
        let result = (currencyValue! / naminal!) * quantity
        let roundValue = round(result * 1000) / 1000
        isTyping = false

        return String(roundValue)
    }

    func calculateCrossRate(for firstOperand: Double, quantity: Double, with secondOperand: Double) -> String {
        var quantity = quantity
        if quantity == 0 {
            quantity = 1
        }
        let result = (quantity * firstOperand) / secondOperand
        let roundValue = round(result * 1000) / 1000
        isTyping = false
        return String(roundValue)
    }
}
