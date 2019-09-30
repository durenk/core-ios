//
//  MonthYearPickerInputType.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 25/09/19.
//

import UIKit

open class MonthYearPickerInputType {
    open var identifier: InputTypeIdentifier = .monthyearpicker
    private var overlay: Button = Button()
    private var instruction: String = DefaultValue.emptyString
    private var textField: TextField = TextField()
    private var sender: FormTableViewController = FormTableViewController()
    private var monthYearPicker = MonthYearPickerView()
    private var displayFormat: String = DefaultValue.emptyString
    open var instructionFont: UIFont = UIFont()
    open var instructionColor: UIColor = .clear
    open var buttonFont: UIFont = UIFont()
    open var buttonColor: UIColor = .clear
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var doneButtonText: String = DefaultValue.emptyString

    public init(
        textField: TextField,
        instruction: String,
        sender: FormTableViewController,
        minimumDate: Date?,
        maximumDate: Date?,
        defaultValue: Date? = nil,
        displayFormat: String
    ) {
        self.textField = textField
        self.instruction = instruction
        self.sender = sender
        self.displayFormat = displayFormat
        monthYearPicker.backgroundColor = .white
        monthYearPicker.locale = Locale(identifier: DateLocale.indonesian)
        monthYearPicker.minimumDate = minimumDate ?? Date()
        monthYearPicker.maximumDate = maximumDate ?? Date()
        guard let date = defaultValue else { return }
        monthYearPicker.defaultDate = date
        self.textField.text = date.formatInMonthAndYear()
    }

    @objc private func close() {
        textField.resignFirstResponder()
        overlay.isHidden = true
        guard let didChangeAction = textField.didChangeAction else { return }
        didChangeAction(textField)
    }

    @objc private func done() {
        textField.text = monthYearPicker.defaultDate.formatIn(format: displayFormat)
        close()
    }

    private func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.setItems(
            [
                createInstruction(),
                createToolbarSpacing(),
                createDoneButton()
            ],
            animated: false
        )
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
        monthYearPicker.layer.borderWidth = borderWidth
        monthYearPicker.layer.borderColor = borderColor.cgColor
    }
}

extension MonthYearPickerInputType: InputType {
    open func didEndEditingHandler(_ textField: TextField) {}

    open func didChangeHandler(_ textField: TextField) {}

    open func resetValue() {}

    open func render() {
        textField.inputView = monthYearPicker
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func didBeginEditingHandler(_ textField: TextField) {
        overlay.isHidden = false
    }

    open func getValue() -> AnyObject {
        return monthYearPicker.defaultDate as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
