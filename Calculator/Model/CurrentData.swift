// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentValue = try? newJSONDecoder().decode(CurrentValue.self, from: jsonData)

import Foundation

// MARK: - CurrentValue
struct CurrentValue: Codable {
    let disclaimer: String
    let date: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}

