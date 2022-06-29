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
    var valute: [String: Valute]

    init?(currencyEntity: CurrentData) {
        date = currencyEntity.date
        valute = currencyEntity.valute
    }
}
