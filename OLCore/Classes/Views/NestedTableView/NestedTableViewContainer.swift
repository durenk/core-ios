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
    private var contentView: NestedTableView = NestedTableView() {
        didSet { setupConstraint() }
    }
    private var minimumContentHeight: CGFloat = 0

    private func setupConstraint() {
        while (true) {
            removeAllSubviews()
            addSubview(contentView)
            contentView.setParentConstraint(parentView: self)
            contentView.tableView.layoutIfNeeded()
            setupHeightConstraint()
            if contentView.tableView.visibleCells.count >= contentView.numberOfRows() {
                return
            }
        }
    }

    private func setupHeightConstraint() {
        let height = contentView.tableView.contentSize.height > minimumContentHeight
            ? contentView.tableView.contentSize.height
            : minimumContentHeight
        if heightConstraint == nil {
            heightConstraint = contentView.tableView.heightAnchor.constraint(equalToConstant: height)
        }
        guard let heightConstraint = heightConstraint else { return }
        heightConstraint.constant = height
        heightConstraint.isActive = true
    }

    public func setContentView(contentView: NestedTableView, minimumContentHeight: CGFloat = 0) {
        self.minimumContentHeight = minimumContentHeight
        self.contentView = contentView
    }

    public func reloadTableView() {
        contentView.tableView.reloadData()
        setupConstraint()
    }
}
