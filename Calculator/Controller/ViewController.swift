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
    @IBOutlet weak var popUpButton: UIButton!
    private let loadingView = LoadingView()

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

    var currencyNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)

        activityIndicator.isHidden = true

        fetchData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.model.checkRelevanceOfDate { string in
                self.showAlert(title: R.string.localizable.warning(), message: string)
            }
        }

    }

    override func viewDidLayoutSubviews() {
        loadingView.frame = view.frame
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

    @IBAction func convertEuroAndDollarPressed(_ sender: UIButton) {
        var title = ""
        switch sender.currentTitle! {
        case "＄/₽":
            title = "USD"
        default:
            title = "EUR"
        }
//        update(title: title)
//    }

//    func update(title: String) {
//        model.getCurrencyExchange(
//            for: title,
//               quantity: currentInput,
//               andShowIn: displayResultLabel,
//               activityIndicator
//        )

        print("abbriviated: \(model.abbreviatedDate ?? "nil")")
        print(model.checkRelevanceOfDate(completion: { string in
            print(string)
        }))
    }

    func fetchData() {
        model.fetctData { [weak self] fetch in
            guard let self = self else { return }
            if fetch {
                self.loadingView.isHidden = true
            } else {
                DispatchQueue.main.async {
                    self.showAlert(
                        title: R.string.localizable.warning(),
                        message: R.string.localizable.no_data_received()
                    )
                    self.loadingView.isHidden = true
                }
            }
        }
    }
}

// MARK: - Extension ViewController
extension ViewController {
    // setting menu for pop up button
//    @available(iOS 14.0, *)
//    func setPopUpMenu(for button: UIButton) {
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
//
//        let pressItem = { [weak self] (action: UIAction) in
//            guard let self = self else { return }
//            let codeValute = action.title.components(separatedBy: "/")
//            self.update(title: codeValute[0])
//        }
//
//        network.fetctData { currencyEntity in
//            var actions = [UIAction]()
//            let currencyNames = currencyEntity.data.sorted(by: <)
//            let ziroMenuItem = UIAction(title: ".../₽", state: .on, handler: pressItem)
//            actions.append(ziroMenuItem)
//
//            for name in currencyNames {
//                let action = UIAction(title: "\(name)/₽", state: .on, handler: pressItem)
//                actions.append(action)
//            }
//            actions[0].state = .on
//            let optionsMenu = UIMenu(title: ".../₽", children: actions)
//
//            DispatchQueue.main.sync {
//                button.menu = optionsMenu
//                button.showsMenuAsPrimaryAction = true
//                if #available(iOS 15.0, *) {
//                    button.changesSelectionAsPrimaryAction = true
//                }
//            }
//        }
//    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
