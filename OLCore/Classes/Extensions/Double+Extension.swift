//
//  Double+Extension.swift
//  OLCore
//
//  Created by DENZA on 07/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

public extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    public func toCurrencyIDR() -> String {
        return "Rp\(String(Int(self)).withThousandSeparator())"
    }

    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
