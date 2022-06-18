//
//  NetworkManager.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.07.2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func dataRaceived(_: NetworkManager, with currencyEntity: CurrencyEntity)
}

class NetworkManager {

    weak var delegate: NetworkManagerDelegate?

    func fetctData(complition: @escaping () -> Void) {
        let urlString = "https://www.cbr-xml-daily.ru/latest.js"
        let URL = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL!) { data, response, error in

            if error != nil {
                print("no data receivad")
                return
            }
            if response != nil {
                print("data received")
            }
            if let data = data {
                if let currencyEntity =  self.parseJSON(withData: data) {
                    self.delegate?.dataRaceived(self, with: currencyEntity)
                    complition()
                }
            }
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> CurrencyEntity? {

        let decoder = JSONDecoder()

        do {
            let currentDate = try decoder.decode(CurrentData.self, from: data)
            guard let currencyEntity = CurrencyEntity(currencyEntity: currentDate) else { return nil }
            return currencyEntity
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

}
