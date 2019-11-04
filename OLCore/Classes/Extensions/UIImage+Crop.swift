//
//  UIImage+Crop.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 04/11/19.
//

import Foundation

extension UIImage {
    func crop(frameSize: CGSize) -> UIImage {
        if #available(iOS 10.0, *) {
            var scale: CGFloat = frameSize.width / self.size.width
            if self.size.height * scale < frameSize.height {
                scale = frameSize.height / self.size.height
            }
            let croppedImageSize = CGSize(
                width: frameSize.width / scale,
                height: frameSize.height / scale
            )
            let croppedImageRect = CGRect(
                origin: CGPoint(
                    x: (self.size.width - croppedImageSize.width) / 2.0,
                    y: (self.size.height - croppedImageSize.height) / 2.0
                ),
                size: croppedImageSize
            )
            let imageRenderer = UIGraphicsImageRenderer(size: croppedImageSize)
            let croppedImage = imageRenderer.image { _ in
                self.draw(at: CGPoint(
                    x: -croppedImageRect.origin.x,
                    y: -croppedImageRect.origin.y
                ))
            }
            return croppedImage
        }
        return self
    }
}
