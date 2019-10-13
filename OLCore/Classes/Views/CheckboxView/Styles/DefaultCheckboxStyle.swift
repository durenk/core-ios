//
//  DefaultCheckboxStyle.swift
//  OLCore
//
//  Created by DENZA on 05/10/19.
//

import UIKit

open class DefaultCheckboxStyle: CheckboxStyle {
    open var checkboxSize = CGFloat(18)
    open var checkboxVerticalPosition = CheckboxVerticalPosition.top
    open var spacing = CGFloat(16)
    open var font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    open var textColor = UIColor.black
    open var checkedImage = CoreStyle.Image.checkedBox
    open var uncheckedImage = CoreStyle.Image.uncheckedBox
    public init() {}
}
