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
    var currency: [String: Valute]

    init?(currencyEntity: CurrentData) {
        date = currencyEntity.date
        currency = currencyEntity.valute
    }
}
