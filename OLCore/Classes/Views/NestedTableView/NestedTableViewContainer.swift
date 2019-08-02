//
//  NestedTableViewContainer.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 24/07/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class NestedTableViewContainer: View {
    private var heightConstraint: NSLayoutConstraint?
    public var contentView: NestedTableView = NestedTableView() {
        didSet {
            while (true) {
                setupConstraint()
                if contentView.tableView.visibleCells.count >= contentView.numberOfRows() {
                    return
                }
            }
        }
    }

    private func setupConstraint() {
        removeAllSubviews()
        addSubview(contentView)
        contentView.setParentConstraint(parentView: self)
        contentView.tableView.layoutIfNeeded()
        setupHeightConstraint()
    }

    private func setupHeightConstraint() {
        let height = contentView.tableView.contentSize.height
        if heightConstraint == nil {
            heightConstraint = contentView.tableView.heightAnchor.constraint(equalToConstant: height)
        }
        guard let heightConstraint = heightConstraint else { return }
        heightConstraint.constant = height
        heightConstraint.isActive = true
    }
}
