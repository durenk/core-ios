//
//  InputProtocol.swift
//  OLCore
//
//  Created by DENZA on 27/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias InputDidChangeHandler = (_ input: InputProtocol) -> Void
public typealias InputDidValidationError = (_ status: ValidationStatus) -> Void
public typealias InputDidValidationSuccess = (_ status: ValidationStatus) -> Void

public protocol InputProtocol {
    var name: String { get set }
    var didChangeAction: InputDidChangeHandler? { get set }
    var didValidationErrorAction: InputDidValidationError? { get set }
    var didValidationSuccessAction: InputDidValidationSuccess? { get set }
    func getValue() -> AnyObject
    func getText() -> String
    func getInputView() -> UIView
    func getTag() -> Int
    func resetValue()
    func isEmpty() -> Bool
}
