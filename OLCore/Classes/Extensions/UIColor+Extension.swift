//
//  UIColor+Extension.swift
//  OLCore
//
//  Created by DENZA on 14/09/19.
//

import Foundation

extension UIColor {
    private convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "invalid red component")
        assert(green >= 0 && green <= 255, "invalid green component")
        assert(blue >= 0 && blue <= 255, "invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
