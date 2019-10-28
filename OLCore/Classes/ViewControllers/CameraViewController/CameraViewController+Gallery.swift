//
//  CameraViewController+Gallery.swift
//  OLCore
//
//  Created by DENZA on 27/10/19.
//

import UIKit

extension CameraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public func importFromGallery() {
        let imagePicker = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) { return }
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        delegate?.cameraViewControllerDidTakeImage(image)
    }
}
