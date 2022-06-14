//
//  CurrentCurrency.swift
//  Calculator
//
//  Created by Иван Тарасенко on 14.06.2022.
//

import Foundation
import UIKit

struct CurrentCurrency {
    let date: String
    let base: String
    let rates: [String: Double]

    init?(currentCurrency: CurrentData) {
        date = currentCurrency.date
        base = currentCurrency.base
        rates = currentCurrency.rates
    }
}
