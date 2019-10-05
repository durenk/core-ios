//
//  CheckboxView.swift
//  OLCore
//
//  Created by DENZA on 05/10/19.
//

import UIKit

open class CheckboxView: UIView {
    private var text: String = DefaultValue.emptyString
    private var style: CheckboxStyle = DefaultCheckboxStyle()
    private var value: Bool = false
    private var checkboxImageView: UIImageView = UIImageView()
    private var checkboxButton: Button = Button()
    private var textLabel: UILabel = UILabel()

    open override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }

    private func createCheckboxImageViewSizeConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
    }

    private func createCheckboxImageViewOriginConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createTextLabelHorizontalConstraint() {
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: style.spacing
        ).isActive = true
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createTextLabelVerticalConstraint() {
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createCheckboxButtonSizeConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize + (style.spacing / 2)
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize + (style.spacing / 2)
        ).isActive = true
    }

    private func createCheckboxButtonOriginConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func setText(_ text: String) {
        self.text = text
        self.textLabel.text = text
    }

    private func renderCheckboxImage() {
        checkboxImageView = UIImageView()
        checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
        checkboxImageView.isUserInteractionEnabled = true
        addSubview(checkboxImageView)
        createCheckboxImageViewSizeConstraint()
        createCheckboxImageViewOriginConstraint()
        setSelected(value)
    }

    private func renderText() {
        textLabel = UILabel()
        textLabel.font = style.font
        textLabel.textColor = style.textColor
        textLabel.textAlignment = .left
        textLabel.contentMode = .topLeft
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        addSubview(textLabel)
        createTextLabelHorizontalConstraint()
        createTextLabelVerticalConstraint()
        setText(text)
    }

    private func renderCheckboxButton() {
        checkboxButton = Button()
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.didPressAction = { self.setSelected(!self.value) }
        addSubview(checkboxButton)
        createCheckboxButtonSizeConstraint()
        createCheckboxButtonOriginConstraint()
    }

    public func configure(
        text: String = DefaultValue.emptyString,
        style: CheckboxStyle = DefaultCheckboxStyle(),
        isSelected: Bool = false
    ) {
        self.text = text
        self.style = style
        self.value = isSelected
    }

    public func render() {
        removeAllSubviews()
        renderCheckboxImage()
        renderCheckboxButton()
        renderText()
    }

    public func isSelected() -> Bool {
        return value
    }

    public func setSelected(_ isSelected: Bool) {
        self.value = isSelected
        checkboxImageView.image = value ? style.checkedImage : style.uncheckedImage
    }
}
