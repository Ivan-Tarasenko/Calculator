//
//  LoadingView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.06.2022.
//

import UIKit
import SnapKit

class LoadingView: UIView {

    let startImage = UIImage(named: "Calc.jpeg")

   var startingImageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(startingImageView)
        startingImageView.image = startImage
        startingImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        startingImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 230 ))
            make.center.equalTo(self)

        }

        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
