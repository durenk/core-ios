//
//  Rule.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class Rule: NSObject {
    public var name: String = DefaultValue.EmptyString
    public var message: String = DefaultValue.EmptyString

    public init(name: String = DefaultValue.EmptyString, message: String = DefaultValue.EmptyString) {
        super.init()
        self.name = name
        self.message = message
    }

    public func validate(_ value: String) -> ValidationStatus {
        let status = ValidationStatus()
        status.isValid = true
        status.message = message
        return status
    }
}
