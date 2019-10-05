//
//  CheckboxStyle.swift
//  OLCore
//
//  Created by DENZA on 05/10/19.
//

import Foundation

public protocol CheckboxStyle {
    var checkboxSize: CGFloat { get }
    var spacing: CGFloat { get }
    var font: UIFont { get }
    var textColor: UIColor { get }
    var checkedImage: UIImage { get }
    var uncheckedImage: UIImage { get }
}
