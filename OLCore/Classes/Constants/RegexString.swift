//
//  RegexString.swift
//  OLCore
//
//  Created by Steven Tiolie on 13/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public struct RegexString {
    public static let passwordRegex = "^(?=.*\\d)(?=.*[a-zA-Z]).{6,}$"
    public static let fullNameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
}
