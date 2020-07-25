//
//  Keyboard.swift
//  Integra
//
//  Created by Tanay Nistala on 6/17/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import UIKit

class DigitButton: UIButton {
    var digit: Int = 0
}

class ImageButton: UIButton {
    var text: String = ""
}

class TextButton: UIButton {
    var text: String = ""
}

class Keyboard: UIView {
    weak var target: UIKeyInput?
    var useDecimalSeparator: Bool

    var numericButtons: [DigitButton] = (0...9).map {
        let button = DigitButton(type: .roundedRect)
        button.digit = $0
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapDigitButton(_:)), for: .touchUpInside)
        return button
    }
    
    var operatorButtons: [ImageButton] = [("plus", "+"), ("minus", "-"), ("multiply", "*"), ("divide", "/"), ("x.squareroot", "√(")].map {
        let button = ImageButton(type: .roundedRect)
        button.text = $0.1
        button.setImage(UIImage(systemName: "\($0.0)"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(textStyle: .title1), forImageIn: .normal)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapImageButton(_:)), for: .touchUpInside)
        return button
    }
    
    var trigButtons: [TextButton] = ["sin", "cos", "tan", "csc", "sec", "cot", "asin", "acos", "atan", "acsc", "asec", "acot"].map {
        let button = TextButton(type: .roundedRect)
        button.text = "\($0)("
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapTextButton(_:)), for: .touchUpInside)
        return button
    }
    
    var otherButtons: [TextButton] = ["(", ")", "x", "y", "ln", "𝛑", "e", "^"].map {
        let button = TextButton(type: .roundedRect)
        button.text = "\($0)"
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapTextButton(_:)), for: .touchUpInside)
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

    lazy var decimalButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        button.setTitle(decimalSeparator, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = UIColor.systemGray4
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = decimalSeparator
        button.addTarget(self, action: #selector(didTapDecimalButton(_:)), for: .touchUpInside)
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

extension Keyboard {
    @objc func didTapDigitButton(_ sender: DigitButton) {
        target?.insertText("\(sender.digit)")
    }
    
    @objc func didTapTextButton(_ sender: TextButton) {
        target?.insertText("\(sender.text)")
    }
    
    @objc func didTapImageButton(_ sender: ImageButton) {
        target?.insertText("\(sender.text)")
    }

    @objc func didTapDecimalButton(_ sender: DigitButton) {
        target?.insertText(Locale.current.decimalSeparator ?? ".")
    }

    @objc func didTapDeleteButton(_ sender: DigitButton) {
        target?.deleteBackward()
    }
}

// MARK: - Private initial configuration methods

private extension Keyboard {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }

    func addButtons() {
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        stackView.spacing = 4

        addSubview(stackView)
        
        let standardButtons = [
            [
                otherButtons[0],
                otherButtons[1],
                numericButtons[7],
                numericButtons[8],
                numericButtons[9],
                operatorButtons[3]
            ],
            [
                otherButtons[2],
                otherButtons[3],
                numericButtons[4],
                numericButtons[5],
                numericButtons[6],
                operatorButtons[2]
            ],
            [
                otherButtons[4],
                operatorButtons[4],
                numericButtons[1],
                numericButtons[2],
                numericButtons[3],
                operatorButtons[1]
            ],
            [
                otherButtons[5],
                otherButtons[6],
                numericButtons[0],
                decimalButton,
                otherButtons[7],
                operatorButtons[0]
            ]
        ]
        
        let extendedButtons = [
            [
                trigButtons[0],
                trigButtons[3],
                trigButtons[6],
                trigButtons[9],
            ],
            [
                trigButtons[1],
                trigButtons[4],
                trigButtons[7],
                trigButtons[10],
            ],
            [
                trigButtons[2],
                trigButtons[5],
                trigButtons[8],
                trigButtons[11],
            ]
        ]

        for row in 0 ..< 4 {
            let subStackView = createStackView(axis: .horizontal)
//            subStackView.spacing = 4
            stackView.addArrangedSubview(subStackView)

            for column in 0 ..< standardButtons[row].count {
                subStackView.addArrangedSubview(standardButtons[row][column])
            }
        }
        
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
