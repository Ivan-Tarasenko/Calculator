//
//  Model.swift
//  Calculator
//
//  Created by Иван Тарасенко on 12.06.2022.
//

import Foundation
import UIKit

class ModelCalc {

    let networkManager = NetworkManager()

    enum Currencys {
        case aud
        case azn
        case gbp
        case amd
        case byn
        case bgn
        case brl
        case huf
        case hkd
        case dkk
        case usd
        case eur
        case inr
        case kzt
        case cad
        case kgs
        case cny
        case mdl
        case nok
        case pln
        case ron
        case xdr
        case sgd
        case tjs
        case tur
        case tmt
        case uzs
        case uah
        case czk
        case sek
        case chf
        case zar
        case krw
        case jpy
    }

    func resultConvert(currentInput: Double, currency: Double, answerLabel: UILabel) {
//        networkManager.fetctData { [self] in
            DispatchQueue.main.sync {
                let result = currentInput / currency
                let rounderValue = round(result * 100) / 100
                answerLabel.txt = String(rounderValue)
            }
//        }
    }

//    func selectCurrencyName(string: inout String) {
//        switch Currencys.aud {
//        case .aud:
//            string = "AUD"
//        case .azn:
//            string = "AZN"
//        case .gbp:
//            string = "GBP"
//        case .amd:
//            string = "AMD"
//        case .byn:
//            string = "BYN"
//        case .bgn:
//            string = "BGN"
//        case .brl:
//            string = "BRL"
//        case .huf:
//            string = "HUF"
//        case .hkd:
//            string = "HKD"
//        case .dkk:
//            string = "DKK"
//        case .usd:
//            string = "USD"
//        case .eur:
//            string = "EUR"
//        case .inr:
//            string = "INR"
//        case .kzt:
//            string = "KZT"
//        case .cad:
//            string = "CAD"
//        case .kgs:
//            string = "KGS"
//        case .cny:
//            string = "CNY"
//        case .mdl:
//            string = "MDL"
//        case .nok:
//            string = "NOK"
//        case .pln:
//            string = "PLN"
//        case .ron:
//            string = "RON"
//        case .xdr:
//            string = "XDR"
//        case .sgd:
//            string = "SGD"
//        case .tjs:
//            string = "TJS"
//        case .tur:
//            string = "TRY"
//        case .tmt:
//            string = "TMT"
//        case .uzs:
//            string = "UZS"
//        case .uah:
//            string = "UAH"
//        case .czk:
//            string = "CZK"
//        case .sek:
//            string = "SEK"
//        case .chf:
//            string = "CHF"
//        case .zar:
//            string = "ZAR"
//        case .krw:
//            string = "KRW"
//        case .jpy:
//            string = "JPY"
//        }
////        return string
//    }

}
