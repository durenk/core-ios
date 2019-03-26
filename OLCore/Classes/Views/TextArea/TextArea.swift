//
//  TextArea.swift
//  OLCore
//
//  Created by DENZA on 22/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias TextAreaDidChangeHandler = (_ textarea: TextArea) -> Void

open class TextArea: UITextView {
    private var showingPlaceholder: Bool = false
    public var name: String = DefaultValue.EmptyString
    public var style: TextFieldStyle! {
        didSet {
            applyStyle()
        }
    }
    public var placeholder: String = DefaultValue.EmptyString {
        didSet {
            renderPlaceholder(text: placeholder)
        }
    }
    public var didChangeAction: InputDidChangeHandler?
    public var didValidationErrorAction: InputDidValidationError?
    public var didValidationSuccessAction: InputDidValidationSuccess?
    public var maxLength: Int = 255

    override open func awakeFromNib() {
        super.awakeFromNib()
        scrollRangeToVisible(NSRange(location: 0, length: 0))
        setValue(DefaultValue.EmptyString)
    }

    private func applyStyle() {
        font = style.font
        textColor = style.color
        backgroundColor = style.backgroundColor
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
        textContainerInset = UIEdgeInsets(top: 14, left: 8, bottom: 28, right: 8)
    }

    private func renderPlaceholder(text: String) {
        showingPlaceholder = true
        textColor = style.placeholderColor
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        if self.text != text {
            self.text = text
            didChange(self)
        }
    }

    private func didChange(_ textArea: TextArea) {
        guard let didChangeAction = didChangeAction else { return }
        didChangeAction(self)
    }

    open func shouldChangeTextHandler(range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = self.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.count > maxLength {
            return false
        }
        if updatedText.isEmpty {
            renderPlaceholder(text: placeholder)
            return false
        }
        if showingPlaceholder && !text.isEmpty {
            setValue(text)
            return false
        }
        didChange(self)
        return true
    }

    open func didChangeSelectionHandler() {
        if showingPlaceholder {
            selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        }
    }

    open func setValue(_ text: String) {
        if text.isEmpty {
            renderPlaceholder(text: placeholder)
            return
        }
        showingPlaceholder = false
        self.text = text
        textColor = style.color
        didChange(self)
    }
}

extension TextArea: InputProtocol {
    public func getInputView() -> UIView {
        return self
    }

    public func getValue() -> AnyObject {
        return getText() as AnyObject
    }

    public func getText() -> String {
        if showingPlaceholder { return DefaultValue.EmptyString }
        return text ?? DefaultValue.EmptyString
    }

    public func resetValue() {
        text = DefaultValue.EmptyString
        tag = 0
    }

    public func isEmpty() -> Bool {
        return showingPlaceholder || getText() == DefaultValue.EmptyString
    }
}
