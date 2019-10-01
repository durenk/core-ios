//
//  DefaultDatePickerStyle.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 01/10/19.
//

import UIKit

class DefaultDatePickerStyle: DatePickerViewStyle {
    var backgroundColor: UIColor = .white
    var instructionFont: UIFont = UIFont()
    var instructionColor: UIColor = .clear
    var doneButtonFont: UIFont = UIFont()
    var doneButtonColor: UIColor = .clear
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    var toolBarStyle: UIBarStyle = .default
    var toolBarTintColor: UIColor = .clear
    var isToolBarTranslucent: Bool = false
    var isOverlayVisible: Bool = true
    var calendarButtonImage: UIImage = UIImage()
    var calendarButtonStyle: ButtonStyle = DefaultButtonStyle()
    var textFieldTintColor: UIColor = .clear
    var displayFormat: String = DefaultValue.emptyString
}
