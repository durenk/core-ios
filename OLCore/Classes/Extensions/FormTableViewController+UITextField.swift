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
        guard let tf: TextField = textField as? TextField else {
            return true
        }
        guard let text: String = tf.text else {
            return true
        }
        let isValidLength = tf.maxLength == 0 || text.count + string.count - range.length <= tf.maxLength
        return isValidLength && tf.shouldChangeCharactersIn(range: range, replacementString: string)
    }
}
