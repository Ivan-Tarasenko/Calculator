//
//  NetworkManager.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.07.2021.
//

import Foundation

struct NetworkManager {

    var onComplition: ((CurrentCurrency) -> Void)?

    func fetctData() {
        let urlString = "https://www.cbr-xml-daily.ru/latest.js"
        let URL = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL!) { data, response, error in
            if let data = data {
                if let currentCurrency =  self.parseJSON(withData: data) {
                    self.onComplition?(currentCurrency)
                }
            }

        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> CurrentCurrency? {

        let decoder = JSONDecoder()

        do {
            let currentDate = try decoder.decode(CurrentData.self, from: data)
            guard let currentCurrency = CurrentCurrency(currentCurrency: currentDate) else { return nil }
            return currentCurrency
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

}
