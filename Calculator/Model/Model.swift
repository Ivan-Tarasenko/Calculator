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


    func inputRestriction(symbol: String, output label: UILabel, typing: inout Bool) {
        if typing {
            label.txt = symbol
            typing = false
        } else {
            if label.txt.count < 20 {
                label.txt  += symbol
            }
        }
    }

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

}
