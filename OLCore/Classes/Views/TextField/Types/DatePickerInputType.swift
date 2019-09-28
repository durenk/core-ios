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
    private var sender: FormTableViewController = FormTableViewController()
    private var datePicker = UIDatePicker()
    open var instructionFont: UIFont = UIFont()
    open var instructionColor: UIColor = .clear
    open var buttonFont: UIFont = UIFont()
    open var buttonColor: UIColor = .clear
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var doneButtonText: String = DefaultValue.emptyString
    open func didEndEditingHandler(_ textField: TextField) {}
    open func didChangeHandler(_ textField: TextField) {}
    open func resetValue() {}

    public init(textField: TextField, instruction: String, sender: FormTableViewController, minimumDate: Date?, maximumDate: Date?, defaultValue: Date? = nil) {
        self.textField = textField
        self.instruction = instruction
        self.sender = sender
        datePicker.backgroundColor = .white
        datePicker.locale = Locale(identifier: DateLocale.indonesian)
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
        overlay = Button(frame: CGRect(x: 0, y: 0, width: sender.view.frame.width, height: sender.view.frame.height))
        overlay.didPressAction = close
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.8
        overlay.isHidden =  true
        sender.navigationController?.view.addSubview(overlay)
        sender.navigationController?.view.bringSubviewToFront(overlay)
    }

    private func renderBorder() {
        datePicker.layer.borderWidth = borderWidth
        datePicker.layer.borderColor = borderColor.cgColor
    }

    open func render() {
        textField.inputView = datePicker
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func didBeginEditingHandler(_ textField: TextField) {
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
}
