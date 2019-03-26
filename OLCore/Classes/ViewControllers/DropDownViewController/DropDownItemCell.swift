//
//  DropDownItemCell.swift
//  OLCore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class DropDownItemCell: TableViewCell {
    private var label: Label = Label()
    public var option: Option = Option()
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray

    override open func loadView() {
        super.loadView()
        contentView.removeAllSubviews()
        contentView.addSubview(label)
        Constraint(
            parentView: contentView,
            childView: label,
            leading: 20,
            trailing: 20,
            top: 16,
            bottom: 16
        ).activate()
    }

    private func renderLabel() {
        label.text = option.text
        label.textColor = option.isActive ? textActiveColor : textInactiveColor
        label.font = textFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    public func render() {
        isUserInteractionEnabled = option.isActive
        renderLabel()
    }
}
