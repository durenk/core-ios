//
//  PasswordRule.swift
//  OLCore
//
//  Created by Steven Tiolie on 12/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class PasswordRule: Rule {
    override public init(name: String, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.EmptyString { return }
        self.message = ValidationErrorMessage.instance.getErrorMessageFormat(PasswordRule.className)
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = value.isValid(regexRule: RegexString.password)
        return status
    }
}
