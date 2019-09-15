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

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let tf: TextField = textField as? TextField else { return true }
        guard let initialText: String = tf.text else { return true }
        let isValidLength = tf.maxLength == 0 || initialText.count + string.count - range.length <= tf.maxLength
        var result = isValidLength && tf.shouldChangeCharactersIn(range: range, replacementString: string)
        if !result { return false }
        var replacementString = string
        if tf.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
            result = false
        }
        if tf.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
            result = false
        }
        if !result {
            let text = tf.text ?? DefaultValue.emptyString
            tf.text = (text as NSString).replacingCharacters(in: range, with: replacementString)
        }
        if result || initialText != tf.text { tf.didChange(tf) }
        return result
    }
}
