//
//  DropDownViewController.swift
//  OLCore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias OptionSelectionHandler = (_ option: Option) -> Void

open class DropDownViewController: TableViewController {
    public var selectedOption: Option = Option()
    public var options: [Option] = [Option]()
    public var didSelectAction: OptionSelectionHandler?
    public var separatorColor: UIColor = .clear
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray

    override open func load() {
        super.load()
        startLoading()
    }

    override open func render() {
        super.render()
        contentView.tableView.register(
            DropDownItemCell.self,
            forCellReuseIdentifier: DropDownItemCell.className
        )
        let section = TableViewSection()
        for option in options {
            section.appendRow(createItemCell(option))
        }
        contentView.appendSection(section: section)
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: UITableView().separatorColor,
            separatorStyle: .singleLine,
            separatorInset: UIEdgeInsets(
                top: 0,
                left: DropDownItemCellContentMargin.horizontal,
                bottom: 0,
                right: 0
            )
        )
    }

    open func createItemCell(_ option: Option) -> DropDownItemCell {
        let cell = contentView.tableView.dequeueReusableCell(withIdentifier: DropDownItemCell.className) as? DropDownItemCell ?? DropDownItemCell()
        cell.option = option
        cell.textFont = textFont
        cell.textActiveColor = textActiveColor
        cell.textInactiveColor = textInactiveColor
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
}
