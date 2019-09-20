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

open class PinInputView: View {
    private var type: PinInputType = .numeric
    private var length: Int = DefaultValue.emptyInt
    private var panViews: [PinPanView] = [PinPanView]()
    private var panWidth: CGFloat = DefaultValue.emptyCGFloat
    private var panSpacing: CGFloat = DefaultValue.emptyCGFloat

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func calculateActualPanWidth(containerWidth: CGFloat) -> CGFloat {
        if panWidth > DefaultValue.emptyCGFloat {
            return panWidth
        }
        if panSpacing == DefaultValue.emptyCGFloat { return DefaultValue.emptyCGFloat }
        let numberOfSpacing = length - 1
        let totalSpacing = panSpacing * CGFloat(numberOfSpacing)
        let freeSpace = containerWidth - totalSpacing
        return freeSpace / CGFloat(length)
    }

    private func calculateActualPanSpacing(containerWidth: CGFloat) -> CGFloat {
        if panWidth <= DefaultValue.emptyCGFloat {
            return panSpacing
        }
        if panWidth == DefaultValue.emptyCGFloat { return DefaultValue.emptyCGFloat }
        let numberOfSpacing = length - 1
        let totalPanWidth = panWidth * CGFloat(length)
        let freeSpace = containerWidth - totalPanWidth
        return freeSpace / CGFloat(numberOfSpacing)
    }

    private func renderPinViews(containerSize: CGSize) {
        panViews.removeAll()
        let panWidth = calculateActualPanWidth(containerWidth: containerSize.width)
        let panSpacing = calculateActualPanSpacing(containerWidth: containerSize.width)
        for index in 0...(length - 1) {
            let frame = CGRect(
                x: (panWidth * CGFloat(index)) + (panSpacing * CGFloat(index)),
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

    private func render() {
        self.layoutIfNeeded()
        let containerSize = bounds.size
        if containerSize.width == DefaultValue.emptyCGFloat { return }
        renderPinViews(containerSize: containerSize)
    }

    public func configure(
        type: PinInputType,
        length: Int,
        panWidth: CGFloat = DefaultValue.emptyCGFloat,
        panSpacing: CGFloat = DefaultValue.emptyCGFloat
    ) {
        self.type = type
        self.length = length
        self.panWidth = panWidth
        self.panSpacing = panSpacing
        self.render()
    }
}
