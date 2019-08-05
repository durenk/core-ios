//
//  NestedTableViewConnector.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 01/08/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class NestedTableViewConnector: NSObject {
    private var cell: NestedTableViewContainerCell?
    private var isEmptyContent: Bool = true

    public func isEmpty() -> Bool {
        return isEmptyContent
    }

    open func render(
        contentView: NestedTableView,
        containerCell: NestedTableViewContainerCell,
        containerTableView: TableView,
        withStartLoading isLoading: Bool = false,
        delegate: NestedTableViewDelegate
    ) {
        if cell == nil {
            cell = containerCell
            contentView.configure(isLoading: isLoading, delegate: delegate)
        }
        guard let cell = cell else {
            isEmptyContent = true
            return
        }
        contentView.render()
        cell.nestedTableViewContainer.contentView = contentView
        isEmptyContent = contentView.isEmpty()
        return
    }

    public func getCell() -> NestedTableViewContainerCell {
        guard let cell = cell else { return NestedTableViewContainerCell() }
        return cell
    }
}
