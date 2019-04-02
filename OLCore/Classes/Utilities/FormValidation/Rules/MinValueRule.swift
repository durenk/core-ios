//
//  NumericRule.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class MinValueRule: Rule {
    private var minValue: Int = 0

    public init(name: String, minValue: Int, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        self.minValue = minValue
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinValueRule.className),
            name,
            String(minValue)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        let number = Int(value.digits) ?? DefaultValue.EmptyInt
        status.isValid = number >= minValue
        return status
    }
}
