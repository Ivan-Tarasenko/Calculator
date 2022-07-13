//
//  LoadingView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 30.06.2022.
//

import UIKit
import SnapKit

class LoadingView: UIView {

    let image = UIImage(named: "Calc.jpeg")

   var imageView = UIImageView()

    init() {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.image = image
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 230 ))
            make.center.equalTo(self)

        }
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
