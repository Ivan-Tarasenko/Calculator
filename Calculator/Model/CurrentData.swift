//
//  CurrentData.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation

struct CurrentData: Codable {
    let date: String
    let base: String
    let rates: [String: Double]
}
