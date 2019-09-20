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

    convenience public init(type: PinInputType, length: Int) {
        self.init(frame: CGRect.zero)
        self.configure(type: type, length: length)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    private func customInit() {}

    private func render() {
        self.layoutIfNeeded()
        let containerSize = bounds.size
        if containerSize.width == DefaultValue.emptyCGFloat { return }
    }

    public func configure(type: PinInputType, length: Int) {
        self.type = type
        self.length = length
        self.render()
    }
}
