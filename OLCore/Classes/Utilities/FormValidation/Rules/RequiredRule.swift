//
//  RequiredRule.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class RequiredRule: Rule {
    override public init(name: String, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(RequiredRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = !value.isEmpty
        return status
    }
}
