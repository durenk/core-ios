//
//  MaxValueRule.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class MaxValueRule: Rule {
    private var maxValue: Int = 0

    public init(name: String, maxValue: Int, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        self.maxValue = maxValue
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MaxValueRule.className),
            name,
            String(maxValue)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = Int(value) ?? DefaultValue.EmptyInt <= maxValue
        return status
    }
}
