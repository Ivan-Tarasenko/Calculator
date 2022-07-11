//
//  PickerView.swift
//  Calculator
//
//  Created by Иван Тарасенко on 04.07.2022.
//

import UIKit
//
//protocol ToolbarPickerViewDelegate: AnyObject {
//    func didTapDone()
//    func didTapCancel()
//}

class PickerView: UIPickerView {

//    public private(set) var toolbar: UIToolbar?
//    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
//        setupToolBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    private func setupToolBar() {
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = .systemBlue
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
//
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
//        toolBar.isUserInteractionEnabled = false
//
//        toolbar = toolBar
//    }
//
//    @objc func doneTapped() {
//        print("Done")
//        toolbarDelegate?.didTapDone()
//    }
//
//    @objc func cancelTapped() {
//        toolbarDelegate?.didTapCancel()
//    }
}
