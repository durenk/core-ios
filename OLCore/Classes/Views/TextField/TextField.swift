//
//  TextField.swift
//  OLCore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias TextFieldDidChangeHandler = (_ textfield: TextField) -> Void

open class TextField: UITextField {
    private var leftIconContainerSize: CGFloat = 0
    private var rightIconContainerSize: CGFloat = 0
    private var defaultContentPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    private var inputType: InputType!
    private var rightButton: Button?
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    public var maxLength: Int = 255
    public var style: TextFieldStyle! {
        didSet {
            applyStyle()
        }
    }
    open var name: String = DefaultValue.EmptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.Textfield,
                name.replacingOccurrences(
                    of: Separator.Whitespace,
                    with: Separator.AccessibilityId
                )
            )
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        inputType = FreeTextInputType(textField: self)
        addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    private func calculateContentPadding() -> UIEdgeInsets {
        var padding = defaultContentPadding
        if leftIconContainerSize != 0 {
            padding.left = leftIconContainerSize + 8
        }
        if rightIconContainerSize != 0 {
            padding.right = rightIconContainerSize
        }
        return padding
    }

    private func applyStyle() {
        font = style.font
        textColor = style.color
        attributedPlaceholder = NSAttributedString(string: placeholder ?? DefaultValue.EmptyString, attributes: [NSAttributedString.Key.foregroundColor: style.placeholderColor])
        backgroundColor = style.backgroundColor
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
    }

    open func setLeftIcon(_ image: UIImage) {
        leftIconContainerSize = frame.size.height
        let verticalPadding = CGFloat(6)
        let leftPadding = CGFloat(12)
        let iconSize = leftIconContainerSize - (verticalPadding * 2)
        let iconView = UIImageView(frame: CGRect(x: leftPadding, y: verticalPadding, width: iconSize, height: iconSize))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: leftIconContainerSize, height: leftIconContainerSize))
        iconContainerView.backgroundColor = .clear
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

    open func setRightIcon(_ image: UIImage) {
        rightIconContainerSize = frame.size.height - 15
        let verticalPadding = CGFloat(5)
        let iconSize = rightIconContainerSize - (verticalPadding * 2)
        let iconView = UIImageView(frame: CGRect(x: 0, y: verticalPadding, width: iconSize, height: iconSize))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: rightIconContainerSize, height: rightIconContainerSize))
        iconContainerView.backgroundColor = .clear
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }

    open func setRightButton(
        icon: UIImage,
        style: ButtonStyle,
        imageRenderingMode: UIImage.RenderingMode = .automatic,
        action: @escaping () -> Void
    ) {
        rightIconContainerSize = frame.size.height
        let button = Button(type: .custom)
        button.setImage(icon.withRenderingMode(imageRenderingMode), for: .normal)
        button.frame = CGRect(
            x: frame.size.width - rightIconContainerSize,
            y: 0,
            width: rightIconContainerSize,
            height: rightIconContainerSize
        )
        button.didPressAction = action
        button.style = style
        rightButton = button
        rightView = rightButton
        rightViewMode = .always
    }

    open func resetState() {
        let button = Button(type: .custom)
        button.didPressAction = nil
        button.style = DefaultButtonStyle()
        rightButton = nil
        rightView = rightButton
        rightViewMode = .never
        rightIconContainerSize = 0
        leftView = nil
        leftViewMode = .never
        leftIconContainerSize = 0
        inputView = nil
        inputType = FreeTextInputType(textField: self)
        inputType.render()
        text = DefaultValue.EmptyString
        inputAccessoryView = nil
    }

    open func secureInput(_ secure: Bool = true) {
        isSecureTextEntry = secure
        let icon = isSecureTextEntry ? CoreStyle.Image.EyeButtonClose : CoreStyle.Image.EyeButtonOpen
        setRightButton(
            icon: icon,
            style: DefaultButtonStyle(),
            action: { self.secureInput(!self.isSecureTextEntry) }
        )
    }

    open func setEnabled(_ enabled: Bool = true) {
        isEnabled = enabled
        guard let rightButton = rightButton else { return }
        rightButton.setEnabled(enabled)
    }

    open func didBeginEditingHandler(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        inputType.didBeginEditingHandler(textField)
    }

    open func didEndEditingHandler(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        inputType.didEndEditingHandler(textField)
    }

    @objc private func didChange(_ textField: UITextField) {
        guard let didChangeAction = didChangeAction else { return }
        guard let textField = textField as? TextField else { return }
        inputType.didChangeHandler(textField)
        didChangeAction(self)
    }

    open func getInputType() -> InputType {
        return inputType
    }

    open func setRightButtonEnabled(_ enabled: Bool) {
        rightButton?.setEnabled(enabled)
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return inputType.shouldChangeCharactersIn(range: range, replacementString: string)
    }
}

extension TextField: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        if inputType == nil { return DefaultValue.EmptyString as AnyObject }
        return inputType.getValue()
    }

    open func getText() -> String {
        return text ?? DefaultValue.EmptyString
    }

    open func resetValue() {
        text = DefaultValue.EmptyString
        tag = 0
        inputType.resetValue()
    }

    open func isEmpty() -> Bool {
        return getText() == DefaultValue.EmptyString
    }

    open func setInputType(_ inputType: InputType) {
        self.inputType = inputType
    }

    open func render() {
        inputType.render()
    }
}
