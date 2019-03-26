//
//  FullNameRule.swift
//  OLCore
//
//  Created by Steven Tiolie on 13/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class FullNameRule: Rule {
    override public init(name: String, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.EmptyString { return }
        self.message = ValidationErrorMessage.instance.getErrorMessageFormat(FullNameRule.className)
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = value.isValid(regexRule: RegexString.fullNameRegex)
        return status
    }
}
