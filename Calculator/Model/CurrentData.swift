//
//  CurrentData.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//
import Foundation

// MARK: - CurrentData
struct CurrentData: Codable {
    let date: String
    let valute: [String: Valute]

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case valute = "Valute"
    }
}

// MARK: - Valute
struct Valute: Codable {
    let name: String
    let value: Double

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
    }
}
