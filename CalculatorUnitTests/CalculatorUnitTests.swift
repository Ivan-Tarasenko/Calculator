//
//  CalculatorUnitTests.swift
//  CalculatorUnitTests
//
//  Created by Иван Тарасенко on 16.07.2022.
//

import XCTest
@testable import Calculator

class CalculatorUnitTests: XCTestCase {

    var mut: ViewModel!
    var sut: ViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mut = ViewModel()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        mut = ViewModel()
        sut = ViewController()
        try super.tearDownWithError()
    }

    func testСharacterШnputКestriction() throws {
        let str = " twenty  characters "
        let label = UILabel()
        mut.limitInput(for: str, andShowIn: label)
        XCTAssert(mut.isTyping)
    }

    func testToEnterFirstCharacterZero() throws {
        let label = UILabel()
        label.text = "0"
        mut.doNotEnterZeroFirst(for: label)
        XCTAssertFalse(mut.isTyping)
    }

    func testSaveFirstOperand() throws {
        let inputNumber = 23.0
        mut.saveFirstОperand(from: inputNumber)
        XCTAssertEqual(inputNumber, mut.firstOperand)
    }

    func testSaveOperation() throws {
        let operation = "+"
        mut.saveOperation(from: operation)
        XCTAssertEqual(operation, mut.operation)
    }

    func testPerformingOperations() throws {
        var currentInput = 0.0
        mut.firstOperand = 15.0
        mut.secondOperand = 10.0
        mut.operation = "+"

        for _ in 1...4 {
            switch mut.operation {
            case "+":
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 25)
                mut.operation = "-"
            case "-":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 5)
                mut.operation = "×"
            case "×":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 150)
                mut.operation = "÷"
            case "÷":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 1.5)
            default:
                break
            }
        }
    }

    func testCalculatePercenage() throws {
        var currentInput = 10.0
        mut.firstOperand = 15.0
        mut.operation = "+"

        for _ in 1...4 {
            switch mut.operation {
            case "+":
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 16.5)
                mut.operation = "-"
            case "-":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 13.5)
                mut.operation = "×"
            case "×":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 1.5)
                mut.operation = "÷"
            case "÷":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 150)
            default:
                break
            }
        }
    }

    func testEnterNumberWithDot() throws {
        mut.isTyping = true
        mut.isDotPlaced = false
        let label = UILabel()

        for _ in 1...2 {
            switch mut.isTyping {
            case true:
                mut.enterNumberWithDot(in: label)
                XCTAssertEqual(label.txt, ".")
                mut.isTyping = false
                mut.isDotPlaced = false
            case false:
                mut.enterNumberWithDot(in: label)
                XCTAssertEqual(label.txt, "0.")
            }
        }
    }

    func testClearButton() throws {
        mut.firstOperand = 20.0
        mut.secondOperand = 30.0
        mut.operation = "+"
        mut.isTyping = true
        mut.isDotPlaced = true
        let label = UILabel()
        label.txt = "54"
        var currentValue = 40.0

        mut.clear(&currentValue, and: label)

        XCTAssertEqual(mut.firstOperand, 0)
        XCTAssertEqual(mut.secondOperand, 0)
        XCTAssertEqual(mut.operation, "")
        XCTAssertEqual(mut.isTyping, false)
        XCTAssertEqual(mut.isDotPlaced, false)
        XCTAssertEqual(label.txt, "0")
        XCTAssertEqual(currentValue, 0)
    }

    func testFetchData() throws {
        let expectionPerfomingOperation = XCTestExpectation(description: "completionPerfomingOperation")

        mut.urlString = "https://www.cbr-xml-daily.ru/daily_json.js"

        mut.fetchData { isFetch in
            if isFetch {
                expectionPerfomingOperation.fulfill()
            }
        }
        wait(for: [expectionPerfomingOperation], timeout: 10)

        XCTAssertNotNil(mut.dateFromData)
        XCTAssertNotNil(mut.currencies)
    }

    func testDoNotReceiveData() throws {
        let expectionPerfomingOperation = XCTestExpectation(description: "completionPerfomingOperation")

        mut.urlString = "https://"

        mut.fetchData { isFetch in
            if isFetch {
            } else {
                expectionPerfomingOperation.fulfill()
            }
        }
        wait(for: [expectionPerfomingOperation], timeout: 10)

        XCTAssertNotNil(mut.dateFromData)
        XCTAssertNotNil(mut.currencies)
    }

    func testGetterCurrencyExchange() throws {
        let charCode = "USD"
        let quentity = 1.0
        var exhcange = ""

        let expectionPerfomingOperation = XCTestExpectation(description: "completionPerfomingOperation")

        mut.fetchData { isFetch in
            if isFetch {
                expectionPerfomingOperation.fulfill()
               exhcange = self.mut.getCurrencyExchange(for: charCode, quantity: quentity)
            }
        }

        wait(for: [expectionPerfomingOperation], timeout: 10)
        XCTAssertNotNil(exhcange)
    }

    func testCalculateCrossRate() throws {
        var exhcange = ""
        let quentity = 1.0
        var firstCurrencyVlue = 0.0
        var secondCurrencyValue = 0.0

        let expectionPerfomingOperation = XCTestExpectation(description: "completionPerfomingOperation")

        mut.fetchData { isFetch in
            if isFetch {
                expectionPerfomingOperation.fulfill()
                firstCurrencyVlue = self.mut.currencies!["USD"]!.value
                secondCurrencyValue = self.mut.currencies!["EUR"]!.value

                exhcange = self.mut.calculateCrossRate(
                    for: firstCurrencyVlue,
                    quantity: quentity,
                    with: secondCurrencyValue
                )
            }
        }

        wait(for: [expectionPerfomingOperation], timeout: 10)
        XCTAssertNotNil(exhcange)
    }

}
