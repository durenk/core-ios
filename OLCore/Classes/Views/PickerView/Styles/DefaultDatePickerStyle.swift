//
//  DefaultDatePickerStyle.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 01/10/19.
//

import UIKit

open class DefaultDatePickerStyle: DatePickerStyle {
    open var backgroundColor: UIColor = .white
    open var instructionFont: UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    open var instructionColor: UIColor = .clear
    open var doneButtonFont: UIFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
    open var doneButtonColor: UIColor = .clear
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var toolBarStyle: UIBarStyle = .default
    open var toolBarTintColor: UIColor = .clear
    open var isToolBarTranslucent: Bool = false
    open var isOverlayVisible: Bool = false
    open var calendarButtonImage: UIImage = CoreStyle.Image.calendarPicker
    open var calendarButtonStyle: ButtonStyle = DefaultButtonStyle()
    open var textFieldTintColor: UIColor = .clear
    open var displayFormat: String = DateFormat.date
    public init() {}
}
