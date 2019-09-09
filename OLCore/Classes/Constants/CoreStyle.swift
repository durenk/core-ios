//
//  CoreStyle.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 11/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public struct CoreStyle {
    public struct Font {
        public static var NavigationTitle: UIFont = UIFont.systemFont(ofSize: 10)
    }
    public struct Image {
        public static var NavigationBackButton: UIImage = UIImage()
        public static var NavigationCloseButton: UIImage = UIImage()
        public static var DropDownArrow: UIImage = UIImage()
        public static var CurrencyIDRActive: UIImage = UIImage()
        public static var CurrencyIDRInactive: UIImage = UIImage()
        public static var EyeButtonOpen: UIImage = UIImage()
        public static var EyeButtonClose: UIImage = UIImage()
    }
    public struct Color {
        public static var NavigationBackground: UIColor = .groupTableViewBackground
        public static var NavigationText: UIColor = .black
        public static var PrimaryBackground: UIColor = .groupTableViewBackground
        public static var ImageBackground: UIColor = .gray
        public static var InputAccessoryActive: UIColor = .clear
        public static var InputAccessoryInactive: UIColor = .clear
    }
}
