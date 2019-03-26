//
//  ButtonStyle.swift
//  OLCore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public protocol ButtonStyle {
    var textFont: UIFont { get }
    var textColor: UIColor { get }
    var textAlignment: NSTextAlignment { get }
    var buttonColorEnabled: UIColor { get }
    var buttonColorDisabled: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var tintColorEnabled: UIColor { get }
    var tintColorDisabled: UIColor { get }
    var cornerRadius: CGFloat { get }
    var contentEdgeInsets: UIEdgeInsets { get }
    var indicatorStyle: UIActivityIndicatorView.Style { get }
}
