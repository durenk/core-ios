//
//  PinInputView.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 20/09/19.
//

import UIKit

public enum PinInputType {
    case numeric
    case alphanumeric
}

open class PinInputView: UIView {
    private var type: PinInputType = .numeric
    private var length: Int = DefaultValue.emptyInt
    private var panViews: [PinPanView] = [PinPanView]()
    private var panWidth: CGFloat = DefaultValue.emptyCGFloat
    private var panSpacing: CGFloat = DefaultValue.emptyCGFloat
    private var keyboardButton: Button = Button()
    private var textField: TextField = TextField()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func calibratePanWidth(containerSize: CGSize) {
        if panWidth < DefaultValue.emptyCGFloat {
            panWidth = DefaultValue.emptyCGFloat
            return
        }
        let maxPanWidth = containerSize.width / CGFloat(length)
        if panWidth > maxPanWidth {
            panWidth = maxPanWidth
            return
        }
    }

    private func calibratePanSpacing(containerSize: CGSize) {
        let numberOfSpacing = length - 1
        let freeSpace = containerSize.width - getTotalPanWidth()
        let maxPanSpacing = freeSpace / CGFloat(numberOfSpacing)
        if panSpacing <= DefaultValue.emptyCGFloat || panSpacing > maxPanSpacing {
            panSpacing = maxPanSpacing
        }
    }

    private func getTotalPanWidth() -> CGFloat {
        return panWidth * CGFloat(length)
    }

    private func getTotalPanSpacing() -> CGFloat {
        return panSpacing * CGFloat(length - 1)
    }

    private func getContainerPadding(containerSize: CGSize) -> CGFloat {
        let remainingWidth = containerSize.width - getTotalPanWidth() - getTotalPanSpacing()
        return remainingWidth / 2
    }

    private func renderPanViews(containerSize: CGSize) {
        panViews.removeAll()
        calibratePanWidth(containerSize: containerSize)
        calibratePanSpacing(containerSize: containerSize)
        if panWidth == DefaultValue.emptyCGFloat { return }
        let containerPadding = getContainerPadding(containerSize: containerSize)
        for index in 0...(length - 1) {
            let frame = CGRect(
                x: containerPadding + (panWidth * CGFloat(index)) + (panSpacing * CGFloat(index)),
                y: DefaultValue.emptyCGFloat,
                width: panWidth,
                height: containerSize.height
            )
            let panView = PinPanView(frame: frame)
            panView.render()
            panViews.append(panView)
            addSubview(panView)
        }
    }

    private func renderTextField(containerSize: CGSize) {
        textField = TextField(frame: CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: containerSize
        ))
        textField.style = InvisibleTextFieldStyle()
        textField.delegate = self
        textField.autocorrectionType = .no
        addSubview(textField)
    }

    private func renderKeyboardButton(containerSize: CGSize) {
        keyboardButton = Button(frame: CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: containerSize
        ))
        keyboardButton.backgroundColor = .clear
        keyboardButton.didPressAction = {
            self.textField.becomeFirstResponder()
        }
        addSubview(keyboardButton)
    }

    private func render() {
        self.layoutIfNeeded()
        let containerSize = bounds.size
        if containerSize.width == DefaultValue.emptyCGFloat { return }
        renderPanViews(containerSize: containerSize)
        renderTextField(containerSize: containerSize)
        renderKeyboardButton(containerSize: containerSize)
    }

    public func configure(
        type: PinInputType,
        length: Int,
        panWidth: CGFloat = DefaultValue.emptyCGFloat,
        panSpacing: CGFloat = DefaultValue.emptyCGFloat,
        style: PinInputStyle = DefaultPinInputStyle()
    ) {
        self.type = type
        self.length = length
        self.panWidth = panWidth
        self.panSpacing = panSpacing
        self.render()
    }

    public func getValue() -> String {
        var value = DefaultValue.emptyString
        for panView in panViews {
            value += String(panView.getValue())
        }
        return value
    }
}

extension PinInputView: UITextFieldDelegate {
}
