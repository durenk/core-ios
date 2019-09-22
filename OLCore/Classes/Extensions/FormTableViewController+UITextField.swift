//
//  FormTableViewController+UITextField.swift
//  OLCore
//
//  Created by DENZA on 09/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

extension FormTableViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        textField.didBeginEditingHandler(textField)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        textField.didEndEditingHandler(textField)
        refreshErrorMessage()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .send {
            validateForm()
            return true
        }
        if textField.returnKeyType == .next {
            guard let nextInput = getNextInput(currentInput: textField) as? UITextField else {
                textField.resignFirstResponder()
                return true
            }
            refreshErrorMessage()
            nextInput.becomeFirstResponder()
            return false
        }
        textField.resignFirstResponder()
        return true
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let textField: TextField = textField as? TextField else { return true }
        guard let initialText: String = textField.text else { return true }
        let isValidLength = textField.maxLength == 0
            || initialText.count + string.count - range.length <= textField.maxLength
        var result = isValidLength && textField.shouldChangeCharactersIn(range: range, replacementString: string)
        if !result { return false }
        var replacementString = string
        if textField.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
            result = false
        }
        if textField.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
            result = false
        }
        if textField.keyboardType == .numberPad {
            replacementString = replacementString.digits
            result = false
        }
        if !result {
            let text = textField.text ?? DefaultValue.emptyString
            textField.text = (text as NSString).replacingCharacters(in: range, with: replacementString)
        }
        if result || initialText != textField.text { textField.didChange(textField) }
        return result
    }
}
