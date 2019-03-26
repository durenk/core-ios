//
//  EqualRule.swift
//  OLCore
//
//  Created by DENZA on 02/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class EqualRule: Rule {
    private var coupleInput: InputProtocol = TextField()

    public init(name: String, coupleInput: InputProtocol, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        self.coupleInput = coupleInput
        if message != DefaultValue.EmptyString { return }
        self.message = String(format: ValidationErrorMessage.instance.getErrorMessageFormat(EqualRule.className), name, coupleInput.name)
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        status.isValid = value == coupleInput.getValue() as? String ?? DefaultValue.EmptyString
        return status
    }
}
