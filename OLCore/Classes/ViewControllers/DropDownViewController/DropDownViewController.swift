//
//  DropDownViewController.swift
//  OLCore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias OptionSelectionHandler = (_ option: Option) -> Void

open class DropDownViewController: FormTableViewController {
    public var selectedOption: Option = Option()
    public var options: [Option] = [Option]()
    public var didSelectAction: OptionSelectionHandler?
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray
    public var separatorColor: UIColor = UITableView().separatorColor ?? .clear
    public var separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    public var contentInset: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private var searchInputCell: TableViewCell?
    open var searchEnabled: Bool { get { return false } }

    override open func load() {
        super.load()
        startLoading()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.register(
            DropDownItemCell.self,
            forCellReuseIdentifier: DropDownItemCell.className
        )
    }

    private func renderSearchInputCell() {
        if !searchEnabled { return }
        if searchInputCell == nil {
            searchInputCell = createSearchBarCell()
        }
        guard let searchInputCell = searchInputCell else { return }
        if searchInputCell.superview != nil { return }
        searchInputCell.frame.size.width = contentView.bounds.width
        if let searchTextField = searchInputCell.getFirstTextField() {
            searchTextField.delegate = self
            searchTextField.returnKeyType = .search
        }
        contentView.setContentMargin(top: searchInputCell.frame.size.height)
        contentView.addSubview(searchInputCell)
    }

    override open func render() {
        super.render()
        renderSearchInputCell()
        let section = TableViewSection()
        for option in options {
            section.appendRow(createItemCell(option))
        }
        contentView.appendSection(section: section)
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: separatorColor,
            separatorStyle: .singleLine,
            separatorInset: separatorInset
        )
    }

    open func createItemCell(_ option: Option) -> DropDownItemCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: DropDownItemCell.className) as? DropDownItemCell ?? DropDownItemCell()
        cell.option = option
        cell.textFont = textFont
        cell.textActiveColor = textActiveColor
        cell.textInactiveColor = textInactiveColor
        cell.contentInset = contentInset
        cell.didSelectAction = didSelectCell
        cell.render()
        return cell
    }

    open func didSelectCell(_ cell: TableViewCell) {
        guard let cell = cell as? DropDownItemCell else { return }
        if selectedOption.id != cell.option.id || selectedOption.text != cell.option.text {
            selectedOption = cell.option
        }
        if let action: OptionSelectionHandler = didSelectAction {
            action(selectedOption)
        }
        navigationController?.popViewController(animated: true)
    }

    open func resetSelection() {
        selectedOption = Option()
    }

    open func createSearchBarCell() -> TableViewCell? {
        return nil
    }
}
