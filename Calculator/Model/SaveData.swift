//
//  SaveData.swift
//  Calculator
//
//  Created by Иван Тарасенко on 13.07.2022.
//

import Foundation

struct KeysDefaults {
   static let keyData = "data"
}

final class SaveData {

    let defaults = UserDefaults.standard

    var data: Data? {
        get {
            return defaults.data(forKey: KeysDefaults.keyData)
        }
        set {
            if let data = newValue {
                print(data)
                defaults.set(data, forKey: KeysDefaults.keyData)
            }
        }
    }
}
