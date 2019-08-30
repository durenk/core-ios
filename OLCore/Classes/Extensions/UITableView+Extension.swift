//
//  UITableView+Extension.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 29/08/19.
//

import Foundation

extension UITableView {
    public func reloadDataWithoutScrollAnimation() {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
}
