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
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    public var style: ButtonStyle = DefaultButtonStyle() {
        didSet {
            applyStyle()
        }
    }
    public var didPressAction: PressButtonHandler?
    override open var isEnabled:Bool {
        didSet {
            isEnabled ? applyEnabledStyle() : applyDisabledStyle()
        }
    }

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
        clipsToBounds = true
        applyEnabledStyle()
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
        contentEdgeInsets = style.contentEdgeInsets
        guard let titleLabel = titleLabel else { return }
        titleLabel.font = style.textFont
        titleLabel.textAlignment = style.textAlignment
    }

    private func applyEnabledStyle() {
        setGradientColors(style.buttonGradientColorsEnabled)
        setTitleColor(style.textColorEnabled, for: .normal)
        backgroundColor = style.buttonColorEnabled
        tintColor = style.tintColorEnabled
    }

    private func applyDisabledStyle() {
        setGradientColors(style.buttonGradientColorsDisabled)
        setTitleColor(style.textColorDisabled, for: .normal)
        backgroundColor = style.buttonColorDisabled
        tintColor = style.tintColorDisabled
    }

    private func setGradientColors(
        _ colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0, y: 0),
        endPoint: CGPoint = CGPoint(x: 1, y: 1)
    ) {
        if colors.isEmpty {
            gradientLayer.removeFromSuperlayer()
            return
        }
        var cgColors = [CGColor]()
        for color in colors { cgColors.append(color.cgColor) }
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = nil
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = cgColors
        if gradientLayer.superlayer == nil {
            layer.addSublayer(gradientLayer)
        }
    }

    public func setTextWithPartialHighlight(
        fullText: String,
        highlightText: String,
        highlightFont: UIFont
    ) {
        let attribute = NSMutableAttributedString(string: fullText)
        let highlightRange = NSRange(
            location: fullText.count - highlightText.count,
            length: highlightText.count
        )
        attribute.addAttribute(
            NSAttributedString.Key.font,
            value: highlightFont,
            range: highlightRange
        )
        attribute.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: style.textColorEnabled,
            range: NSRange(location: 0, length: fullText.count)
        )
        setAttributedTitle(attribute, for: .normal)
    }

    @objc public func pressButtonHandler(_ sender: UIButton) {
        guard let action = didPressAction else { return }
        action()
    }

    @objc public func setStyle(_ style: ButtonStyle) {
        self.style = style
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
