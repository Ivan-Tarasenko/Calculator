//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }

    // MARK: - Actions
    @IBAction func numbersPrassed(_ sender: UIButton) {
        model.doNotEnterZeroFirst(for: displayResultLabel)
        model.limitInput(for: sender.currentTitle!, andshowIn: displayResultLabel)
    }

    @IBAction func operationsPressed(_ sender: UIButton) {
        model.saveFirstОperand(from: currentInput)
        model.saveOperation(from: sender.currentTitle!)
    }

    @IBAction func equalityPressed(_ sender: UIButton) {
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

    @IBAction func cleaningButtonPressed(_ sender: UIButton) {
        model.clear(&currentInput, and: displayResultLabel)
    }

    @IBAction func convertDollarPressed(_ sender: UIButton) {
        model.getCurrencyExchange(
            for: "USD",
               quantity: currentInput,
               andShowIn: displayResultLabel,
               activityIndicator
        )
    }
    @IBAction func convertEuroPressed(_ sender: UIButton) {
        model.getCurrencyExchange(
            for: "EUR",
               quantity: currentInput,
               andShowIn: displayResultLabel,
               activityIndicator
        )
    }

}
