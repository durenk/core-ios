//
//  Option.swift
//  OLCore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class Option: Model {
    public var id: String = DefaultValue.EmptyString
    public var text: String = DefaultValue.EmptyString
    public var isActive: Bool = true

    public init(id: String = DefaultValue.EmptyString, text: String = DefaultValue.EmptyString, isActive: Bool = true) {
        self.id = id
        self.text = text
        self.isActive = isActive
    }
}
