//
//  ImageSelectionInput.swift
//  OLCore
//
//  Created by Steven Tiolie on 24/05/19.
//

import UIKit

open class ImageSelectionInput: Button {
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    private var sender: ImageInputTableViewCell = ImageInputTableViewCell()
    open func didChangeHandler(_ imageSelectionInput: ImageSelectionInput) {}
    open var name: String = DefaultValue.EmptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.Button,
                name.toAccessibilityFormat()
            )
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func resetState() {}
    
    open func setup(
        name: String,
        sender: ImageInputTableViewCell,
        didChangeAction: @escaping InputDidChangeHandler = {_ in }
    ) {
        self.name = name
        self.sender = sender
        self.didChangeAction = didChangeAction
    }
}

extension ImageSelectionInput: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        return sender.getSelectedPhoto() as AnyObject
    }
    
    open func getText() -> String {
        return sender.getSelectedPhoto() == nil ? DefaultValue.EmptyString : name
    }
    
    open func resetValue() {
        sender.removeSelectedPhoto()
    }
    
    open func isEmpty() -> Bool {
        return getText() == DefaultValue.EmptyString
    }
}

