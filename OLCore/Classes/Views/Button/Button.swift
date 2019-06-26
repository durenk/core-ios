//
//  Button.swift
//  OLCore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias PressButtonHandler = () -> Void

open class Button: UIButton {
    public var style: ButtonStyle = DefaultButtonStyle() {
        didSet {
            applyStyle()
        }
    }
    public var didPressAction: PressButtonHandler?

    convenience public init(type buttonType: UIButton.ButtonType) {
        self.init(frame: CGRect.zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    private func customInit() {
        addTarget(self, action: #selector(self.pressButtonHandler(_:)), for: .touchUpInside)
    }

    private func applyStyle() {
        setTitleColor(style.textColor, for: .normal)
        backgroundColor = style.buttonColorEnabled
        tintColor = style.tintColorEnabled
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
        contentEdgeInsets = style.contentEdgeInsets
        guard let titleLabel = titleLabel else { return }
        titleLabel.font = style.textFont
        titleLabel.textAlignment = style.textAlignment
    }

    public func setTextWithPartialHighlight(
        fullText: String,
        highlightText: String,
        highlightFont: UIFont
    ) {
        let attribute = NSMutableAttributedString(string: fullText)
        let highlightRange = NSRange(location: fullText.count - highlightText.count, length: highlightText.count)
        attribute.addAttribute(NSAttributedString.Key.font, value: highlightFont, range: highlightRange)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: style.textColor, range: NSRange(location: 0, length: fullText.count))
        setAttributedTitle(attribute, for: .normal)
    }

    public func setEnabled(_ enabled: Bool = true) {
        isEnabled = enabled
        if isEnabled {
            backgroundColor = style.buttonColorEnabled
            tintColor = style.tintColorEnabled
        } else {
            backgroundColor = style.buttonColorDisabled
            tintColor = style.tintColorDisabled
        }
    }

    @objc public func pressButtonHandler(_ sender: UIButton) {
        guard let action = didPressAction else { return }
        action()
    }

    open override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        guard let title = title else { return }
        accessibilityIdentifier = String(
            format: AccessibilityIdentifier.Button,
            title.toAccessibilityFormat()
        )
    }
}
