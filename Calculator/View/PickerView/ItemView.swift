//
//  ItemView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 09.07.2022.
//

import UIKit
import SnapKit

final class ItemView: UIView {

    private let title = UILabel()
    private let subtitle = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitle()
        setupSubtitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(title: String, subtitle: String) -> ItemView {

        let itemView = ItemView()
        itemView.title.txt = title
        itemView.subtitle.txt = subtitle

        return itemView
    }

    private func setupTitle() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(7)
            make.top.equalTo(self).inset(2)
        }
        title.font = UIFont.systemFont(ofSize: 20)
    }

    private func setupSubtitle() {
        addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title).inset(23)
            make.leading.equalTo(self).inset(7)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.textColor = .darkGray
    }

}
