//
//  NestedTableView.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 23/07/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public protocol NestedTableViewDelegate: class {
    func nestedTableViewDidChangedState(loading isLoading: Bool)
}

open class NestedTableView: TableView, TableViewContainerProtocol {
    private weak var nestedTableViewDelegate: NestedTableViewDelegate?
    private var isLoading: Bool = false
    open var sectionCollection: SectionCollection = SectionCollection()
    open func registerNibs() {}
    open func renderContent() {}

    convenience init() {
        self.init(frame: CGRect.zero)
        commonInit(sender: self, isRender: false)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.isScrollEnabled = false
    }

    open func configure(isLoading: Bool = false, delegate: NestedTableViewDelegate?) {
        self.isLoading = isLoading
        self.nestedTableViewDelegate = delegate
    }

    open func load() {
        startLoading()
    }

    public func startLoading() {
        isLoading = true
        nestedTableViewDelegate?.nestedTableViewDidChangedState(loading: isLoading)
    }

    public func stopLoading() {
        isLoading = false
        nestedTableViewDelegate?.nestedTableViewDidChangedState(loading: isLoading)
    }

    open func renderLoadingState() {
        appendSection(section: sectionCollection.activityIndicator)
    }

    open func render() {
        removeAllSection()
        sectionCollection.configure(contentView: self)
        isLoading ? renderLoadingState() : renderContent()
        tableView.reloadData()
    }
}
