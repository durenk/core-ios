//
//  ImageSelectionInput.swift
//  OLCore
//
//  Created by Steven Tiolie on 24/05/19.
//

import UIKit

public typealias ImageSelectionInputDidChangeHandler = (_ imageSelectionInput: ImageSelectionInput) -> Void

public protocol ImageSelectionInputDelegate: class {
    func selectionInputDidChangeImage(_ imageSelectionInput: ImageSelectionInput)
}

open class ImageSelectionInput: Button {
    public weak var delegate: ImageSelectionInputDelegate?
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
//    private var controller: SelectionInputViewController = SelectionInputViewController()
    private var sender: ViewController = ViewController()
    open func didChangeHandler(_ imageSelectionInput: ImageSelectionInput) {}
    open var name: String = DefaultValue.EmptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.Button,
                name.toAccessibilityFormat()
            )
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func resetState() {}
    
//    open func setup(
//        name: String,
//        sender: ViewController,
//        controller: SelectionInputViewController,
//        defaultValue: [Option]? = [Option](),
//        didChangeAction: @escaping InputDidChangeHandler = {_ in }
//        ) {
//        self.name = name
//        self.sender = sender
//        self.controller = controller
//        self.controller.screenTitle = self.name
//        self.didChangeAction = didChangeAction
//        self.didPressAction = {
//            self.controller.didSelectAction = self.didSelectOptions
//            self.sender.present(
//                NavigationController(rootViewController: self.controller),
//                animated: true,
//                completion: nil
//            )
//        }
//        if let defaultValue = defaultValue {
//            self.controller.selectedOptions = defaultValue
//            didSelectOptions(defaultValue)
//        }
//    }
    
//    private func didSelectOptions(_ options: [Option]) {
//        delegate?.selectionInputDidEndEditing(self)
//        guard let didChangeAction = didChangeAction else { return }
//        didChangeAction(self)
//    }

}
