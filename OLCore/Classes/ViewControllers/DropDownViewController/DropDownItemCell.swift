//
//  DropDownItemCell.swift
//  OLCore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

internal struct DropDownItemCellContentMargin {
    static let vertical = CGFloat(20)
    static let horizontal = CGFloat(20)
}

open class DropDownItemCell: TableViewCell {
    public var option: Option = Option()
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray
    public var mainLabel: Label = Label() // was private
    public var descriptionLabel: Label = Label() // was private
    private let containerWidth = SizeHelper.getWidth(
        containerWidth: SizeHelper.ScreenWidth,
        horizontalPadding: DropDownItemCellContentMargin.horizontal
    )

    override open func loadView() {
        super.loadView()
        contentView.removeAllSubviews()
        contentView.addSubview(mainLabel)
        Constraint(
            parentView: contentView,
            childView: mainLabel,
            leading: DropDownItemCellContentMargin.horizontal,
            trailing: DropDownItemCellContentMargin.horizontal + (containerWidth - mainLabel.frame.size.width),
            top: DropDownItemCellContentMargin.vertical,
            bottom: DropDownItemCellContentMargin.vertical
        ).activate()
        if !option.description.isEmpty {
            contentView.addSubview(descriptionLabel)
            Constraint(
                parentView: contentView,
                childView: descriptionLabel,
                leading: DropDownItemCellContentMargin.horizontal + (containerWidth - descriptionLabel.frame.size.width),
                trailing: DropDownItemCellContentMargin.horizontal,
                top: DropDownItemCellContentMargin.vertical,
                bottom: DropDownItemCellContentMargin.vertical
            ).activate()
        }
    }

    private func renderMainLabel() {
        mainLabel.text = option.text
        mainLabel.textColor = option.isActive ? textActiveColor : textInactiveColor
        mainLabel.font = textFont
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.textAlignment = .left
        mainLabel.frame.size.width = SizeHelper.getPercentValue(
            percent: option.description.isEmpty ? 100 : 54,
            valueOf: containerWidth
        )
    }

    private func renderDescriptionLabel() {
        descriptionLabel.text = option.description
        descriptionLabel.textColor = option.isActive
            ? textActiveColor.withAlphaComponent(0.5)
            : textInactiveColor
        descriptionLabel.font = textFont
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .right
        descriptionLabel.frame.size.width = SizeHelper.getPercentValue(
            percent: 45,
            valueOf: containerWidth
        )
    }

    public func render() {
        isUserInteractionEnabled = option.isActive
        renderMainLabel()
        renderDescriptionLabel()
    }
}
