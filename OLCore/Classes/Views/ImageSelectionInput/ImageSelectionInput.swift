//
//  ImageSelectionInput.swift
//  OLCore
//
//  Created by Steven Tiolie on 24/05/19.
//

import UIKit

open class ImageSelectionInput: Button {
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    private var sender: ImageInputTableViewCell = ImageInputTableViewCell()
    private var senderParentView: ViewController = ViewController()
    private var imagePickerController: ImagePicker!
    private var menuTitle: String = DefaultValue.EmptyString
    private var cameraButtonTitle: String = DefaultValue.EmptyString
    private var galleryButtonTitle: String = DefaultValue.EmptyString
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
    
    override open func awakeFromNib() {
        
    }
    
    open func resetState() {}
    
    open func setup(
        name: String,
        sender: ImageInputTableViewCell,
        senderParentView: ViewController,
        menuTitle: String,
        cameraButtonTitle: String,
        galleryButtonTitle: String,
        didChangeAction: @escaping InputDidChangeHandler = {_ in }
        
    ) {
        self.name = name
        self.sender = sender
        self.senderParentView = senderParentView
        self.menuTitle = menuTitle
        self.cameraButtonTitle = cameraButtonTitle
        self.galleryButtonTitle = galleryButtonTitle
        self.didChangeAction = didChangeAction
        imagePickerController = ImagePicker(
            presentationController: self.senderParentView,
            delegate: sender,
            overlay: UIView())
        
        self.didPressAction = showPhotoSourceOptions
    }
    
    private func showPhotoSourceOptions() {
        imagePickerController.present(from: self.senderParentView.view,
                                      menuTitle: self.menuTitle,
                                      cameraButtonTitle: self.cameraButtonTitle,
                                      galleryButtonTitle: self.galleryButtonTitle
        )
    }
}


extension ImageSelectionInput: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        return sender.getSelectedPhoto() as AnyObject
    }
    
    open func getText() -> String {
        return sender.getSelectedPhoto() == nil ? DefaultValue.EmptyString : name
    }
    
    open func resetValue() {
        sender.removeSelectedPhoto()
    }
    
    open func isEmpty() -> Bool {
        return getText() == DefaultValue.EmptyString
    }
}

