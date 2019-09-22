//
//  Option.swift
//  OLCore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class Option {
    public var key: String = DefaultValue.emptyString
    public var text: String = DefaultValue.emptyString
    public var isActive: Bool = true
    public var description: String = DefaultValue.emptyString
    public var value: Any

    public init(
        key: String = DefaultValue.emptyString,
        text: String = DefaultValue.emptyString,
        isActive: Bool = true,
        description: String = DefaultValue.emptyString,
        value: Any = DefaultValue.emptyAny
    ) {
        self.key = key
        self.text = text
        self.isActive = isActive
        self.description = description
        self.value = value
    }
}
