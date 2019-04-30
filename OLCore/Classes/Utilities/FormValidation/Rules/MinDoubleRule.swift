//
//  MinDoubleRule.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 30/04/19.
//

import Foundation

public class MinDoubleRule: Rule {
    private var minValue: Double = 0

    public init(name: String, minValue: Double, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        self.minValue = minValue
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinDoubleRule.className),
            name,
            minValue.clean
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        let number = Double(value) ?? DefaultValue.EmptyDouble
        status.isValid = number >= minValue
        return status
    }
}
