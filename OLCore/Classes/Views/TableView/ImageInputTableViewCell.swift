//
//  ImageInputTableViewCell.swift
//  OLCore
//
//  Created by Steven Tiolie on 29/05/19.
//

import UIKit

open class ImageInputTableViewCell: TableViewCell, ImagePickerDelegate {
    open func imagePickerDidSelect(image: UIImage) {}
    private var selectedPhoto: UIImage?
    
    open func setSelectedPhoto(image: UIImage) {
        selectedPhoto = image
    }

    open func getSelectedPhoto() -> UIImage? {
        return selectedPhoto
    }
    
    open func removeSelectedPhoto() {
        return selectedPhoto = nil
    }
}
