//
//  NetworkManager.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.07.2021.
//

import Foundation

struct NetworkManager {
    
func valueValute() {
    let urlString = "https://www.cbr-xml-daily.ru/latest.js"
    let URL = URL(string: urlString)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL!) { data, response, error in
        if let data = data {
            self.parseJSON(withData: data)
//            let a = String(data: data, encoding: .utf8)
//            print(a!)
            
        }
        
    }
    task.resume()
  }

    func parseJSON(withData data: Data) {

        let decoder = JSONDecoder()
        var valueUSD = Double()
        

        do {
            let CurrentValue = try decoder.decode(CurrentValue.self, from: data)
            var dictionaryValute = [String:Double]()
            dictionaryValute = CurrentValue.rates
            for (key, value) in dictionaryValute {
                if key == "USD" {
                    valueUSD = value
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
