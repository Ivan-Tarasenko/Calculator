//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    @IBOutlet weak var popUpButton: UIButton!
    private let loadingView = LoadingView()
    private let pickerView = PickerView()
   var dataSource = PickerDataSource()

    let viewModel = ViewModel()

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
        view.addSubview(loadingView)
        view.addSubview(pickerView)
        pickerView.center = view.center
        pickerView.isHidden = true
        fetchData()
        bind()
    }

    override func viewDidLayoutSubviews() {
        loadingView.frame = view.frame
        pickerView.center = view.center
    }

    // MARK: - Actions
    @IBAction func numbersPrassed(_ sender: UIButton) {
        viewModel.doNotEnterZeroFirst(for: displayResultLabel)
        viewModel.limitInput(for: sender.currentTitle!, andshowIn: displayResultLabel)
    }

    @IBAction func operationsPressed(_ sender: UIButton) {
        viewModel.saveFirstОperand(from: currentInput)
        viewModel.saveOperation(from: sender.currentTitle!)
    }

    @IBAction func equalityPressed(_ sender: UIButton) {
        viewModel.performOperation(for: &currentInput)
    }

    @IBAction func plusMinusPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func procentPressed(_ sender: UIButton) {
        viewModel.calculatePercentage(for: &currentInput)
    }

    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }

    @IBAction func dotButtonPressed(_ sender: UIButton) {
        viewModel.enterNumberWithDot(in: displayResultLabel)
    }

    @IBAction func cleaningButtonPressed(_ sender: UIButton) {
        viewModel.clear(&currentInput, and: displayResultLabel)
    }

    @IBAction func convertEuroAndDollarPressed(_ sender: UIButton) {
        var charCode = ""
        switch sender.currentTitle! {
        case "＄/₽":
            charCode = "USD"
        default:
            charCode = "EUR"
        }

        displayResultLabel.txt = viewModel.getCurrencyExchange(for: charCode, quantity: currentInput)

    }

    @IBAction func pickerViewPressed(_ sender: UIButton) {
        pickerView.isHidden = false
    }

    func bind() {
        viewModel.onUpDataCurrency = { [weak self, dataSource] data in
            guard let self = self else { return }
            dataSource.currency = data
            self.pickerView.dataSource = dataSource
            self.pickerView.delegate = dataSource
        }

    }

    func fetchData() {
        viewModel.fetctData { [weak self] fetch in
            guard let self = self else { return }
            if fetch {
                self.loadingView.isHidden = true
                self.viewModel.checkRelevanceOfDate { massage in
                    self.showAlert(title: R.string.localizable.warning(), message: massage)
                }
                
                if #available(iOS 15.0, *) {
                    self.setPopUpMenu(for: self.popUpButton)
                } else {
                    self.showAlert(
                        title: R.string.localizable.warning(),
                        message: R.string.localizable.pleace_updata_iOS()
                    )
                }
            } else {
                self.showAlert(
                    title: R.string.localizable.warning(),
                    message: R.string.localizable.no_data_received()
                )
            }
        }
    }
}

// MARK: - Extension ViewController
extension ViewController {

    // setting menu for pop up button
    @available(iOS 15.0, *)
    func setPopUpMenu(for button: UIButton) {
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        let pressItem = { [weak self] (action: UIAction) in
            guard let self = self else { return }
            self.displayResultLabel.txt = self.viewModel.getCurrencyExchange(
                for: "\(action.title)",
                quantity: self.currentInput
            )
        }

        var actions = [UIAction]()

        let ziroMenuItem = UIAction(title: ".../₽", state: .on, handler: pressItem)
        actions.append(ziroMenuItem)

        if let currency = viewModel.currency {
            let sortCurrency = currency.sorted(by: {$0.key > $1.key})

            for (key, value) in sortCurrency {
                let action = UIAction(title: key, subtitle: value.name, state: .on, handler: pressItem)
                actions.append(action)
            }
        }

        button.menu = UIMenu(title: ".../₽", children: actions)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true

    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.loadingView.isHidden = true
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
