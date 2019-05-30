//
//  ImageInputTableViewCell.swift
//  OLCore
//
//  Created by Steven Tiolie on 29/05/19.
//

import UIKit

open class ImageInputTableViewCell: TableViewCell {
    private var savedImage: UIImage?
    
    open func setSavedImage(image: UIImage) {
        savedImage = image
    }

    open func getSavedImage() -> UIImage? {
        return savedImage
    }
}
