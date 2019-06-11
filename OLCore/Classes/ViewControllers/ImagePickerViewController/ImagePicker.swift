//
//  ImagePicker.swift
//  Kelolala
//
//  Created by Steven Tiolie on 28/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    func imagePickerDidSelect(image: UIImage)
}

class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private var overlay: UIView = UIView()
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    private var alertController: UIAlertController!

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate, overlay: UIView) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
        self.overlay = overlay
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            if self.pickerController.sourceType == .camera {
                self.pickerController.cameraFlashMode = .off
                self.pickerController.cameraCaptureMode = .photo
                self.pickerController.cameraDevice = .rear
            }
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView, menuTitle: String, cameraButtonTitle: String, galleryButtonTitle: String ) {

        alertController = UIAlertController(title: menuTitle, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: cameraButtonTitle) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: galleryButtonTitle) {
            alertController.addAction(action)
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.closeAlert)
        )

        self.presentationController?.present(alertController, animated: true, completion: {
            self.alertController.view.superview?.isUserInteractionEnabled = true
            self.alertController.view.superview?.subviews.first?.addGestureRecognizer(gesture)
        })
    }
    
    @objc func closeAlert() {
        alertController.dismiss(animated: true, completion: nil)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        if let tempImage = image {
            if let imageData = tempImage.jpegData(compressionQuality: 0.60) {
                guard let selectedImage = UIImage(data: imageData) else { return }
                self.delegate?.imagePickerDidSelect(image: selectedImage)
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {}
