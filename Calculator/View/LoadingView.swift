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
        setupImage()
        setupColor(dark: .black, light: .white, defaultColor: .white)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImage() {
        addSubview(imageView)
        imageView.image = image
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 170, height: 170 ))
            make.center.equalTo(self)
        }
    }
}
