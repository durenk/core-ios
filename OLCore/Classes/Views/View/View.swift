//
//  View.swift
//  OLCore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class View: UIView {
    private var parentConstraint: Constraint!
    private let accessoryLayer: CAGradientLayer = CAGradientLayer()

    private func appendAccessoryLayer() {
        if accessoryLayer.superlayer != nil { return }
        layer.addSublayer(accessoryLayer)
    }

    public func resetParentConstraint(parentView: UIView) {
        if parentConstraint != nil {
            parentView.removeConstraint(parentConstraint.leading)
            parentView.removeConstraint(parentConstraint.trailing)
            parentView.removeConstraint(parentConstraint.top)
            parentView.removeConstraint(parentConstraint.bottom)
        }
    }

    public func setParentConstraint(parentView: UIView) {
        setParentConstraint(parentView: parentView, bottom: 0)
    }

    public func setParentConstraint(parentView: UIView, bottom: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        resetParentConstraint(parentView: parentView)
        if !self.isDescendant(of: parentView) {
            parentView.addSubview(self)
        }
        parentConstraint = Constraint(parentView: parentView, childView: self)
        parentConstraint.bottom.constant = bottom
        parentView.addConstraint(parentConstraint.leading)
        parentView.addConstraint(parentConstraint.trailing)
        parentView.addConstraint(parentConstraint.top)
        parentView.addConstraint(parentConstraint.bottom)
        parentConstraint.activate()
    }

    public func setGradientColors(
        _ colors: [CGColor],
        startPoint: CGPoint = CGPoint(x: 0, y: 0),
        endPoint: CGPoint = CGPoint(x: 1, y: 1)
    ) {
        accessoryLayer.frame = bounds
        accessoryLayer.startPoint = startPoint
        accessoryLayer.endPoint = endPoint
        accessoryLayer.colors = colors
        appendAccessoryLayer()
    }
}
