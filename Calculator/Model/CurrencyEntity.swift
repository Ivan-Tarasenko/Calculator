//
//  CurrentCurrency.swift
//  Calculator
//
//  Created by Иван Тарасенко on 14.06.2022.
//

import Foundation
import UIKit

struct CurrencyEntity {
    let date: String
    let base: String
    let rates: [String: Double]
    var data: [String]

    init?(currencyEntity: CurrentData) {
        date = currencyEntity.date
        base = currencyEntity.base
        rates = currencyEntity.rates
        data = currencyEntity.rates.map {$0.key}
    }
}
