//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    let network = NetworkManager()
    
    var stillTyping = true
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var resultProcent:Double = 0
    var opiretionSing: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArrey = value.components(separatedBy: ".")
            if valueArrey[1] == "0" {
                displayResultLabel.text = "\(valueArrey[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            stillTyping = true
        }
    }
    
   
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
//    Actions
//    Кнопки с цыфрами
    @IBAction func numberPrassed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping {
                displayResultLabel.text = number
                stillTyping = false
            } else {
                if displayResultLabel.text!.count < 20 {
                    displayResultLabel.text = displayResultLabel.text! + number
            }
        }
    }
    
//    Кнопки с математическими операторами
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
    
//    Кнопка Равно
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
    
//    Кнопка очистки
    @IBAction func clear(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        opiretionSing = ""
        stillTyping = true
        dotIsPlased = false
    }
    
//    Кнопка минуса у числа
    @IBAction func plusMinusPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
//    Кнопка процентов
    @IBAction func procentPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
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
            displayResultLabel.text = "\(valueArrayProcent[0])"
        } else {
            displayResultLabel.text = String(resultProcent)
        }
    }
    
//    Кнопка квадратного корня
    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
//    Кнопка точки
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        
        if !stillTyping && !dotIsPlased {
            displayResultLabel.text = displayResultLabel.text! + "."
        }else if stillTyping && !dotIsPlased {
            displayResultLabel.text = "0."
            stillTyping = false
    }
}
//    Кновка конвертации в доллар
    @IBAction func convertFromDollarToRuble(_ sender: UIButton) {
        network.valueValute()
        print("тест")
}
}
