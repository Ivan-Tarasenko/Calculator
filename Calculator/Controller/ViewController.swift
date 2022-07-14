//
//  ViewController.swift
//  Calculator
//
//  Created by Иван Тарасенко on 16.07.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var crossRateButton: UIButton!
    var dataSource = PickerDataSource()
    private let loadingView = LoadingView()
    private let pickerView = PickerView()
    private let toolBar = ToolBar()
    private let contentView = ContentView()

    let viewModel = ViewModel()
    let save = SaveData()

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
        toolBar.toolbarDelegate = self
        setupLoadingView()
        setupPickerView()
        setupContentView()
        setupToolBar()
        fetchData()
        bind()
    }

    override func viewDidLayoutSubviews() {
        loadingView.frame = view.frame
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

    @IBAction func convertDollarPressed(_ sender: UIButton) {
        displayResultLabel.txt = viewModel.getCurrencyExchange(for: "USD", quantity: currentInput)

    }

    @IBAction func convertInEuroPressed(_ sender: UIButton) {
        displayResultLabel.txt = viewModel.getCurrencyExchange(for: "EUR", quantity: currentInput)
    }

    @IBAction func crossRatePressed(_ sender: UIButton) {
        sender.titleLabel?.adjustsFontSizeToFitWidth = true
        contentView.isHidden = false
    }
}

// MARK: - Extension ViewController
extension ViewController {

    func setupLoadingView() {
        view.addSubview(loadingView)
    }

    func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: view.bounds.width, height: 328))
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
        }
        contentView.isHidden = true
    }

    func setupPickerView() {
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: view.bounds.width, height: 284))
            make.bottom.equalTo(contentView).inset(0)
            make.trailing.leading.equalTo(contentView).inset(0)
        }
    }

    func setupToolBar() {
        contentView.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(contentView).inset(0)
        }
    }

    func bind() {
        viewModel.onUpDataCurrency = { [weak self, dataSource] data in
            guard let self = self else { return }
            dataSource.currency = data
            self.pickerView.dataSource = dataSource
            self.pickerView.delegate = dataSource
            dataSource.title = self.viewModel.currencyKeys()
            dataSource.subtitle = self.viewModel.currencyName()
        }

    }

    func fetchData() {
        viewModel.fetctData { [weak self] fetch in
            guard let self = self else { return }
            if fetch {
                self.loadingView.isHidden = true

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
                    message: "\(R.string.localizable.no_data_received()) \(self.viewModel.abbreviatedDate!)"
                )

                if #available(iOS 15.0, *) {
                    self.setPopUpMenu(for: self.popUpButton)
                } else {
                    self.showAlert(
                        title: R.string.localizable.warning(),
                        message: R.string.localizable.pleace_updata_iOS()
                    )
                }
            }
        }
    }

    // setting menu for pop up button
    @available(iOS 15.0, *)
    func setPopUpMenu(for button: UIButton) {
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        let pressItem = { [weak self] (action: UIAction) in
            guard let self = self else { return }
            if action.title != ".../₽" {
                self.displayResultLabel.txt = self.viewModel.getCurrencyExchange(
                    for: "\(action.title)",
                    quantity: self.currentInput
                )
            }
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

// MARK: - Tool bar delegate
extension ViewController: ToolbarDelegate {

    func didTapDone() {
        contentView.isHidden = true
        let crossRate = viewModel.colculateCrossRate(
            firstOperand: dataSource.firstValue,
            secondOperand: dataSource.secondValue
        )
        displayResultLabel.txt = crossRate
        crossRateButton.setTitle(" \(dataSource.firstTitle)/\(dataSource.secondTitle) ", for: .normal)
    }

    func didTapCancel() {
        contentView.isHidden = true
    }
}
