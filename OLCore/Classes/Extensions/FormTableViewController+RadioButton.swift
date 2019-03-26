//
//  FormTableViewController+RadioButton.swift
//  OLCore
//
//  Created by DENZA on 03/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension FormTableViewController: RadioButtonDelegate {
    public func radioButtonDidEndEditing(_ radioButton: RadioButton) {
        dismissObsoleteErrorMessage()
    }
}
