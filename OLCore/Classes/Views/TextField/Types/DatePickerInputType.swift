//
//  DatePickerInputType.swift
//  OLCore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class DatePickerInputType: InputType {
    open var identifier: InputTypeIdentifier = .datepicker
    private var overlay: Button = Button()
    private var instruction: String = DefaultValue.emptyString
    private var textField: TextField = TextField()
    private var presenter: UINavigationController = UINavigationController()
    private var datePicker = UIDatePicker()
    private var calendarButtonImage: UIImage = CoreStyle.Image.calendarPicker
    open var instructionFont: UIFont = UIFont()
    open var instructionColor: UIColor = .clear
    open var buttonFont: UIFont = UIFont()
    open var buttonColor: UIColor = .clear
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var doneButtonText: String = DefaultValue.emptyString
    open var calendarButtonStyle: ButtonStyle = DefaultButtonStyle()
    open var isOverlayVisible: Bool = true
    open func didChangeHandler(_ textField: TextField) {}
    open func resetValue() {}

    public init(
        textField: TextField,
        instruction: String = DefaultValue.emptyString,
        presenter: UINavigationController,
        minimumDate: Date?,
        maximumDate: Date?,
        defaultValue: Date? = nil,
        calendarButtonImage: UIImage = CoreStyle.Image.calendarPicker,
        displayFormat: String = DateFormat.date,
        locale: String = DateLocale.indonesian
    ) {
        self.textField = textField
        self.instruction = instruction
        self.presenter = presenter
        self.calendarButtonImage = calendarButtonImage
        datePicker.backgroundColor = .white
        datePicker.locale = Locale(identifier: locale)
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.datePickerMode = .date
        guard let date = defaultValue else { return }
        datePicker.date = date
        self.textField.text = date.formatInFullDate()
    }

    @objc private func close() {
        textField.resignFirstResponder()
        overlay.isHidden = true
        guard let didChangeAction = textField.didChangeAction else { return }
        didChangeAction(textField, datePicker.date)
    }

    @objc private func done() {
        textField.text = datePicker.date.formatInFullDate()
        close()
    }

    private func createToolBar() {
        if doneButtonText.isEmpty && instruction.isEmpty { return }
        let toolBar = UIToolbar()
        toolBar.setItems([
            createInstruction(),
            createToolbarSpacing(),
            createDoneButton()
        ], animated: false)
        toolBar.barStyle = .default
        toolBar.tintColor = buttonColor
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    private func createDoneButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: doneButtonText,
            style: .plain,
            target: self,
            action: #selector(self.done)
        )
        button.setTitleTextAttributes([NSAttributedString.Key.font: buttonFont], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: buttonFont], for: .highlighted)
        return button
    }

    private func createToolbarSpacing() -> UIBarButtonItem {
        return UIBarButtonItem (
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
    }

    private func createInstruction() -> UIBarButtonItem {
        let instructionLabel = Label()
        instructionLabel.text = instruction
        instructionLabel.font = instructionFont
        instructionLabel.textColor = instructionColor
        return UIBarButtonItem(customView: instructionLabel)
    }

    private func createOverlay() {
        if !isOverlayVisible { return }
        overlay = Button(frame: CGRect(
            x: 0,
            y: 0,
            width: presenter.view.frame.width,
            height: presenter.view.frame.height
        ))
        overlay.didPressAction = close
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.8
        overlay.isHidden =  true
        presenter.view.addSubview(overlay)
        presenter.view.bringSubviewToFront(overlay)
    }

    private func renderBorder() {
        datePicker.layer.borderWidth = borderWidth
        datePicker.layer.borderColor = borderColor.cgColor
    }

    private func renderCalendarButton() {
        textField.setRightButton(
            icon: calendarButtonImage,
            style: calendarButtonStyle,
            action: {
                self.didBeginEditingHandler(self.textField)
            }
        )
    }

    open func render() {
        textField.inputView = datePicker
        renderCalendarButton()
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func didBeginEditingHandler(_ textField: TextField) {
        textField.becomeFirstResponder()
        overlay.isHidden = false
    }

    open func getValue() -> AnyObject {
        return datePicker.date as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    open func didEndEditingHandler(_ textField: TextField) {
        if !doneButtonText.isEmpty { return }
        textField.text = datePicker.date.formatInFullDate()
    }
}
