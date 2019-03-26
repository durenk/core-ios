//
//  Double+Extension.swift
//  OLCore
//
//  Created by DENZA on 07/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

public extension Double {
    public func toCurrencyIDR() -> String {
        return "Rp\(String(Int(self)).withThousandSeparator())"
    }
}
