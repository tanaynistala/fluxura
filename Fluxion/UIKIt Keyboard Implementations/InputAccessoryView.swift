//
//  InputAccessoryView.swift
//  Integra
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import UIKit

class NavButton: UIButton {
    var text: String = ""
}

class AccessoryView: UIView {
    weak var target: UIKeyInput?
    var useDecimalSeparator: Bool
    
    var navButtons: [NavButton] = ["chevron.left", "chevron.right"].map {
        let button = NavButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "\($0)"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(textStyle: .title1), forImageIn: .normal)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapImageButton(_:)), for: .touchUpInside)
        return button
    }

    var deleteButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("⌫", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = "Delete"
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()

    init(target: UIKeyInput, useDecimalSeparator: Bool = false) {
        self.target = target
        self.useDecimalSeparator = useDecimalSeparator
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension AccessoryView {
    @objc func didTapImageButton(_ sender: NavButton) {
        target?.insertText("\(sender.text)")
    }

    @objc func didTapDeleteButton(_ sender: DigitButton) {
        target?.deleteBackward()
    }
}

// MARK: - Private initial configuration methods

private extension AccessoryView {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }

    func addButtons() {
        let stackView = createStackView(axis: .horizontal)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        stackView.spacing = 4

        addSubview(stackView)
        
        let buttons = [navButtons[0], navButtons[1], deleteButton]
        
        let keyboardPicker = UISegmentedControl(items: ["Standard", "Extended"])
        keyboardPicker.setEnabled(true, forSegmentAt: 0)
        stackView.addArrangedSubview(keyboardPicker)
        
        for item in 0 ..< 3 {
            stackView.addArrangedSubview(buttons[item])
        }
        
        stackView.addArrangedSubview(UIView())
        
//        for row in 0 ..< 3 {
//            let subStackView = createStackView(axis: .horizontal)
//            stackView.addArrangedSubview(subStackView)
//
//            for column in 0 ..< 4 {
//                subStackView.addArrangedSubview(extendedButtons[row][column])
//            }
//        }

//        let subStackView = createStackView(axis: .horizontal)
//        stackView.addArrangedSubview(subStackView)
//
//        if useDecimalSeparator {
//            subStackView.addArrangedSubview(decimalButton)
//        } else {
//            let blank = UIView()
//            blank.layer.borderWidth = 0.5
//            blank.layer.borderColor = UIColor.darkGray.cgColor
//            subStackView.addArrangedSubview(blank)
//        }
//
//        subStackView.addArrangedSubview(numericButtons[0])
//        subStackView.addArrangedSubview(deleteButton)
    }

    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
}
