//
//  UINavigationController+Extension.swift
//  OLCore
//
//  Created by DENZA on 12/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public extension UINavigationController {
    public func applyTransparentStyle() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
    }

    public func setNavigationBarColor(_ color: UIColor) {
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = color
        navigationBar.isTranslucent = false
    }
}
