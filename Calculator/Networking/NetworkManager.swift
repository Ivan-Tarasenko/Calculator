//
//  NetworkManager.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.07.2021.
//

//import Foundation
//
//class NetworkManager {
//
//    var onCompletion: (() -> Void)?
//
//    func fetctData(completion: @escaping (CurrencyEntity) -> Void) {
//        let urlString = "https://www.cbr-xml-daily.ru/latest.js"
//        let URL = URL(string: urlString)
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: URL!) { data, _, error in
//            if let error = error {
//                self.onCompletion?()
//                print("error")
//                return
//            }
//            if let data = data {
//                if let currencyEntity =  self.parseJSON(withData: data) {
//                    completion(currencyEntity)
//                }
//            }
//        }
//        task.resume()
//    }
//
//    func parseJSON(withData data: Data) -> CurrencyEntity? {
//
//        let decoder = JSONDecoder()
//
//        do {
//            let currentDate = try decoder.decode(CurrentData.self, from: data)
//            guard let currencyEntity = CurrencyEntity(currencyEntity: currentDate) else { return nil }
//            return currencyEntity
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//
//}
