//
//  DefaultButtonStyle.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 11/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class DefaultButtonStyle: ButtonStyle {
    open var textFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
    open var textColorEnabled = UIColor.blue
    open var textColorDisabled = UIColor.gray
    open var textAlignment = NSTextAlignment.center
    open var buttonColorEnabled = UIColor.clear
    open var buttonColorDisabled = UIColor.clear
    open var buttonGradientColorsEnabled = [UIColor]()
    open var buttonGradientColorsDisabled = [UIColor]()
    open var borderColor = UIColor.clear
    open var borderWidth = CGFloat(0)
    open var tintColorEnabled = UIColor.blue
    open var tintColorDisabled = UIColor.blue
    open var cornerRadius: CGFloat = 0
    open var contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    open var indicatorStyle = UIActivityIndicatorView.Style.white
    public init() {}
}
