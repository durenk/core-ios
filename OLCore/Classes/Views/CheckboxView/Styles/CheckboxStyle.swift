//
//  CheckboxStyle.swift
//  OLCore
//
//  Created by DENZA on 05/10/19.
//

import Foundation

public enum CheckboxVerticalPosition {
    case top
    case center
}

public protocol CheckboxStyle {
    var checkboxSize: CGFloat { get }
    var checkboxVerticalPosition: CheckboxVerticalPosition { get }
    var spacing: CGFloat { get }
    var font: UIFont { get }
    var textColor: UIColor { get }
    var checkedImage: UIImage { get }
    var uncheckedImage: UIImage { get }
}
