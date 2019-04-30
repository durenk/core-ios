//
//  MaxDoubleRule.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 30/04/19.
//

import UIKit

import Foundation

public class MaxDoubleRule: Rule {
    private var maxValue: Double = 0

    public init(name: String, maxValue: Double, message: String = DefaultValue.EmptyString) {
        super.init(name: name, message: message)
        self.maxValue = maxValue
        if message != DefaultValue.EmptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MaxDoubleRule.className),
            name,
            maxValue.clean
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        let status = super.validate(value)
        let number = Double(value) ?? DefaultValue.EmptyDouble
        status.isValid = number <= maxValue
        return status
    }
}
