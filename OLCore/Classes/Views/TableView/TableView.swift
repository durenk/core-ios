//
//  TableView.swift
//  OLCore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

@objc public protocol TableViewDelegate {
    @objc optional func tableViewDidCommontInit(_ tableView: TableView)
    @objc optional func tableViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func tableViewDidEndDecelerating(_ scrollView: UIScrollView)
}

open class TableView: View {
    private var sections: [TableViewSection] = [TableViewSection]()
    public weak var delegate: TableViewDelegate?
    public var tableView: UITableView!
    public var tableViewConstraint: Constraint!
    public var registeredCellIdentifiers: [String] = [String]()
    public var rememberTableViewContentOffset: CGPoint = CGPoint(x: 0, y: 0)

    open func commonInit(sender: TableViewContainerProtocol) {
        sender.registerNibs()
        createTableView()
        configureTableView()
        registerCellIdentifiers()
        sender.render()
        delegate?.tableViewDidCommontInit?(self)
    }

    private func createTableView() {
        if tableView != nil && tableView.superview != nil {
            tableView.removeFromSuperview()
        }
        tableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        addSubview(tableView)
        createTableViewConstraint()
    }

    private func registerCellIdentifiers() {
        for cellIdentifier in registeredCellIdentifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }

    private func createTableViewConstraint() {
        resetTableViewConstraint()
        tableViewConstraint = Constraint(parentView: self, childView: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(tableViewConstraint.leading)
        self.addConstraint(tableViewConstraint.trailing)
        self.addConstraint(tableViewConstraint.top)
        self.addConstraint(tableViewConstraint.bottom)
        tableViewConstraint.activate()
    }

    private func resetTableViewConstraint() {
        if tableViewConstraint != nil {
            self.removeConstraint(tableViewConstraint.leading)
            self.removeConstraint(tableViewConstraint.trailing)
            self.removeConstraint(tableViewConstraint.top)
            self.removeConstraint(tableViewConstraint.bottom)
        }
    }

    open func configureTableView() {
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.contentInset = UIEdgeInsets.zero
        if #available(iOS 9.0, *) {
            tableView.cellLayoutMarginsFollowReadableWidth = false
        }
    }

    open func setTableViewSeparator(show: Bool, separatorColor: UIColor?, separatorStyle: UITableViewCell.SeparatorStyle?, separatorInset: UIEdgeInsets?) {
        if show {
            if separatorColor != nil {
                tableView.separatorColor = separatorColor
            }
            if separatorStyle != nil {
                tableView.separatorStyle = separatorStyle!
            }
            if separatorInset != nil {
                tableView.separatorInset = separatorInset!
            }
        } else {
            tableView.separatorStyle = .none
        }
    }

    public func hasSectionAtIndex(index: NSInteger) -> Bool {
        return index < sections.count
    }

    public func hasIndexPath(indexPath: IndexPath) -> Bool {
        return hasSectionAtIndex(index: indexPath.section) && sections[indexPath.section].hasRowAtIndex(index: indexPath.row)
    }

    public func appendSection(section: TableViewSection) {
        section.tag = sections.count
        self.sections.append(section)
    }

   public func appendSections(sections: [TableViewSection]) {
        for section in sections {
            appendSection(section: section)
        }
    }

    public func removeAllSection() {
        sections.removeAll()
    }

    public func removeAllSectionForLoadingPurpose() {
        if sections.isEmpty { return }
        var placeholderSections = [TableViewSection]()
        for index in 0...(sections.count - 1) where sections[index].keepWhileLoading {
            placeholderSections.append(sections[index])
        }
        removeAllSection()
        sections = placeholderSections
    }

    public func hasCell(cell: TableViewCell) -> Bool {
        for section in sections {
            if section.hasCell(cell) {
                return true
            }
        }
        return false
    }

    public func indexPathOfCell(cell: TableViewCell) -> IndexPath {
        for section in 0...(sections.count - 1) {
            let row = sections[section].indexOfCell(cell: cell)
            if row >= 0 {
                return IndexPath(row: row, section: section)
            }
        }
        return IndexPath()
    }

    public func scrollTo(row: TableViewCell) {
        let indexPath = indexPathOfCell(cell: row)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    public func scrollToVisible(row: TableViewCell) {
        guard let superview = row.superview else { return }
        var visibleRect = row.frame
        visibleRect = tableView.convert(visibleRect, to: superview)
        tableView.scrollRectToVisible(visibleRect, animated: true)
    }

    public func dequeueReusableCellWithIdentifier(nibName: String) -> UITableViewCell {
        if let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: nibName) {
            return cell
        }
        return UITableViewCell()
    }

    public func reloadSection(_ section: TableViewSection) {
        tableView.reloadSections(
            IndexSet(integer: section.tag),
            with: UITableView.RowAnimation.automatic
        )
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasSectionAtIndex(index: section) {
            return sections[section].numberOfRows()
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasIndexPath(indexPath: indexPath) {
            let section = sections[indexPath.section]
            let cell = section.getRowAtIndex(index: indexPath.row)
            cell.drawSeparator(tableView: tableView, indexPath: indexPath, rowCount: section.numberOfRows())
            cell.loadView()
            return cell
        }
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasIndexPath(indexPath: indexPath) {
            let row = sections[indexPath.section].getRowAtIndex(index: indexPath.row)
            row.onSelected()
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension TableView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.endEditing(true)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.tableViewDidScroll?(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.tableViewDidEndDecelerating?(scrollView)
    }
}
