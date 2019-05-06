//
//  RadioButton.swift
//  OLCore
//
//  Created by DENZA on 02/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit
import DLRadioButton

public protocol RadioButtonDelegate: class {
    func radioButtonDidEndEditing(_ radioButton: RadioButton)
}

open class RadioButton: DLRadioButton {
    private var container: UIView = UIView()
    private var bottomView: UIView = UIView()
    weak public var delegate: RadioButtonDelegate?
    public var name: String = DefaultValue.EmptyString
    public var didChangeAction: InputDidChangeHandler?
    public var didValidationErrorAction: InputDidValidationError?
    public var didValidationSuccessAction: InputDidValidationSuccess?
    private var selectedOption: Option = Option()
    private var option: Option = Option() {
        didSet {
            setTitle(option.text, for: .normal)
            accessibilityIdentifier = String(
                format: AccessibilityIdentifier.RadioButton,
                name,
                option.id
            ).toAccessibilityFormat()
            accessibilityLabel = String(
                format: AccessibilityIdentifier.RadioButton,
                name,
                option.text
            ).toAccessibilityFormat()
        }
    }

    public init(
        frame: CGRect,
        option: Option,
        titleColor: UIColor,
        titleFont: UIFont,
        iconColor: UIColor,
        container: UIView,
        bottomView: UIView,
        name: String = DefaultValue.EmptyString
    ) {
        super.init(frame: frame)
        setup(
            option: option,
            titleColor: titleColor,
            titleFont: titleFont,
            iconColor: iconColor,
            container: container,
            bottomView: bottomView,
            name: name
        )
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(
        option: Option,
        titleColor: UIColor,
        titleFont: UIFont,
        iconColor: UIColor,
        container: UIView,
        bottomView: UIView,
        name: String = DefaultValue.EmptyString
    ) {
        self.name = name
        self.option = option
        self.container = container
        self.bottomView = bottomView
        self.indicatorColor = iconColor
        self.iconColor = iconColor
        self.iconSize = 18
        titleLabel?.font = titleFont
        contentHorizontalAlignment = .left
        setTitleColor(titleColor, for: .normal)
        setTitleColor(currentTitleColor, for: .normal)
    }

    public func setOptions(_ options: [Option]) {
        guard let option = options.first else { return }
        guard let titleLabel = titleLabel else { return }
        self.option = option
        if (options.count - 1) == otherButtons.count { return }
        for i in 1..<options.count {
            let originX = frame.origin.x
            let originY = frame.origin.y + CGFloat(40 * i)
            let radioButton = RadioButton(
                frame: CGRect(
                    x: originX,
                    y: originY,
                    width: frame.size.width,
                    height: frame.size.height
                ),
                option: options[i],
                titleColor: currentTitleColor,
                titleFont: titleLabel.font,
                iconColor: iconColor,
                container: container,
                bottomView: bottomView,
                name: name
            )
            container.addSubview(radioButton)
            otherButtons.append(radioButton)
        }
        for i in 0..<otherButtons.count {
            applyRadioButtonConstraint(index: i)
        }
        setupAction()
    }

    private func applyRadioButtonConstraint(index: Int) {
        let nextButton = otherButtons[index]
        let previousButton = (index == 0) ? self : otherButtons[index-1]
        setConstraintLeading(item: nextButton, toItem: previousButton)
        setConstraintTrailing(item: otherButtons[index], toItem: container)
        setConstraintTop(item: nextButton, toItem: previousButton)
        if index == otherButtons.count - 1 {
            setConstraintBottom(item: otherButtons[index], toItem: bottomView)
        }
    }

    private func setupAction() {
        addTarget(self, action: #selector(selectedRadioButton), for: .touchUpInside)
        for radioButton in otherButtons {
            radioButton.addTarget(self, action: #selector(selectedRadioButton(_:)), for: .touchUpInside)
        }
    }

    @objc private func selectedRadioButton(_ sender: DLRadioButton) {
        guard let radioButton = sender as? RadioButton else { return }
        if radioButton.option.id != selectedOption.id {
            selectedOption = radioButton.option
        } else {
            selectedOption = Option()
            radioButton.isSelected = false
        }
        delegate?.radioButtonDidEndEditing(self)
        guard let didChangeAction = didChangeAction else { return }
        didChangeAction(self)
    }

    private func setConstraintTop(item: UIView, toItem: UIView) {
        NSLayoutConstraint(
            item: item,
            attribute: .top,
            relatedBy: .equal,
            toItem: toItem,
            attribute: .bottom,
            multiplier: 1,
            constant: 10
        ).isActive = true
    }

    private func setConstraintBottom(item: UIView, toItem: UIView) {
        NSLayoutConstraint(
            item: item,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: toItem,
            attribute: .top,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }

    private func setConstraintLeading(item: UIView, toItem: UIView) {
        NSLayoutConstraint(
            item: item,
            attribute: .leading,
            relatedBy: .equal,
            toItem: toItem,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }

    private func setConstraintTrailing(item: UIView, toItem: UIView) {
        NSLayoutConstraint(
            item: item,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: toItem,
            attribute: .trailingMargin,
            multiplier: 1,
            constant: 1
        ).isActive = true
    }

    public func select(option selectOption: Option) {
        if option.id == selectOption.id {
            isSelected = true
            self.selectedOption = selectOption
            return
        }
        for button in otherButtons {
            guard let radioButton = button as? RadioButton else { continue }
            if radioButton.option.id == selectOption.id {
                radioButton.isSelected = true
                self.selectedOption = selectOption
                return
            }
        }
    }
}

extension RadioButton: InputProtocol {
    public func getInputView() -> UIView {
        return self
    }

    public func getValue() -> AnyObject {
        return selectedOption
    }

    public func getText() -> String {
        return selectedOption.text
    }

    public func resetValue() {
        tag = 0
    }

    public func isEmpty() -> Bool {
        return getText() == DefaultValue.EmptyString
    }
}
