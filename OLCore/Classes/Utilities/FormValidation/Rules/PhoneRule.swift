//
//  PhoneRule.swift
//  OLCore
//
//  Created by DENZA on 01/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class PhoneRule: Rule {
    override public init(name: String, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(PhoneRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = value.prefix(2) == "08" && value.count >= 10 && value.count <= 13
        return status
    }
}
