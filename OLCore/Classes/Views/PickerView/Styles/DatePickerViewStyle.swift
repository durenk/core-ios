//
//  DatePickerViewStyle.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 01/10/19.
//

import UIKit

@objc public protocol DatePickerViewStyle {
    var backgroundColor: UIColor { get }
    var instructionFont: UIFont { get }
    var instructionColor: UIColor { get }
    var buttonFont: UIFont { get }
    var buttonColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var borderColor: UIColor { get }
    var toolBarStyle: UIBarStyle { get }
    var isToolBarTranslucent: Bool { get }
}
