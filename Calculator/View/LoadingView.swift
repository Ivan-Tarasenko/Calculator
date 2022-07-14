//
//  LoadingView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.06.2022.
//

import UIKit
import SnapKit

class LoadingView: UIView {

    let image = UIImage(named: "Start image")

   var imageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.image = image
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 170, height: 170 ))
            make.center.equalTo(self)

        }
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .black
                default:
                    return .white
                }
            }
        } else {
            backgroundColor = .white
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
