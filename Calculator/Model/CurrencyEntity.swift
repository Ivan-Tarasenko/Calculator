//
//  CurrentCurrency.swift
//  Calculator
//
//  Created by Иван Тарасенко on 14.06.2022.
//

import Foundation
import UIKit

struct CurrencyEntity: Codable {
    let date: String
    var currency: [String: Currency]

    init?(currencyEntity: CurrentData) {
        date = currencyEntity.date
        currency = currencyEntity.valute

    }
}
