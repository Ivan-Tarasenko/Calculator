//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ViewModel {

    var isTyping = false
    var isDotPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation: String = ""
    var dateFromData: String?
    let currentDate = NSDate()

    var abbreviatedDate: String {
            var abbriviatedData: String = ""
            if let dateFromData = dateFromData {
                let dateArray = dateFromData.components(separatedBy: "T")
                abbriviatedData = dateArray[0]
            }
            return abbriviatedData
    }

    func checkRelevanceOfDate(completion: (String) -> Void) {

        var alertText: String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formatterDate = formatter.string(from: currentDate as Date)
        let currentDateArray = formatterDate.components(separatedBy: "-")
        let dateFromDateArray = abbreviatedDate.components(separatedBy: "-")
        let differenceOfDays = Int(currentDateArray[2])! - Int(dateFromDateArray[0])!

        if currentDateArray[0] != dateFromDateArray[0] {
            alertText = NSLocalizedString("difference_in_years", comment: "")
        }

        completion(alertText)
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

    func fetctData(completion: @escaping () -> Void) {
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        let URL = URL(string: urlString)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: URL!) { data, _, error in
            if error != nil {
                completion()
            }
            if let data = data {
                print(data)
                if let currencyEntity =  self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        self.dateFromData = currencyEntity.date
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

//    func getCurrencyExchange(for name: String, quantity: Double, andShowIn label: UILabel, _ activityIndicator: UIActivityIndicatorView) {
//
//        var currencyValue: Double = 0.0
//        network.fetctData { currencyEntity in
//            for (key, value) in currencyEntity.rates where key == name {
//                currencyValue = value
//
//                DispatchQueue.main.sync {
//                    label.txt = ""
//                    activityIndicator.isHidden = false
//                    activityIndicator.startAnimating()
//                }
//
//            }
//            DispatchQueue.main.async {
//                let result = quantity / currencyValue
//                let rounderValue = round(result * 100) / 100
//                label.txt = String(rounderValue)
//                self.isTyping = false
//
//                activityIndicator.startAnimating()
//                activityIndicator.isHidden = true
//            }
//        }
//    }
}
