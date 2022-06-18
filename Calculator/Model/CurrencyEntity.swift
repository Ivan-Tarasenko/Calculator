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
//    var data: [Currency: Double]

    init?(currencyEntity: CurrentData) {
        date = currencyEntity.date
        base = currencyEntity.base
        rates = currencyEntity.rates
    }
}


struct Currency: RawRepresentable, Hashable {
    var rawValue: String
}