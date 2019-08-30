//
//  InputValidator.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class InputValidator {
    private var lastStatus = ValidationStatus()
    var input: InputProtocol = TextField()
    var rules: [Rule] = [Rule]()

    public init(input: InputProtocol, rules: [Rule] = [Rule]()) {
        self.input = input
        self.rules = rules
    }

    public func validate(ruleType: AnyClass? = nil) -> ValidationStatus {
        lastStatus = ValidationStatus()
        for rule in rules {
            if ruleType != nil && !rule.isKind(of: ruleType!) { continue }
            let status = rule.validate(input.getText())
            if !status.isValid {
                lastStatus = status
                return lastStatus
            }
        }
        return lastStatus
    }

    public func getLastStatus() -> ValidationStatus {
        return lastStatus
    }
}
