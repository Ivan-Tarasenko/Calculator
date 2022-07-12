//
//  ToolBar.swift
//  Calculator
//
//  Created by Иван Тарасенко on 10.07.2022.
//

import UIKit

protocol ToolbarDelegate: AnyObject {
    func didTapDone()
    func didTapCancel()
}

class ToolBar: UIToolbar {

    public weak var toolbarDelegate: ToolbarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setToolBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setToolBar() {
        barStyle = UIBarStyle.default
        isTranslucent = true
        tintColor = .systemBlue
        sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneTapped)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )

        setItems([cancelButton, spaceButton, doneButton], animated: true)
        isUserInteractionEnabled = true
    }

    @objc func doneTapped() {
        toolbarDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        toolbarDelegate?.didTapCancel()
    }

}
