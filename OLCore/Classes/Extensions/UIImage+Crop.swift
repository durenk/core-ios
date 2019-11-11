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

    public func scaledImage(maxDimension: CGFloat) -> UIImage {
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        if size.width > size.height {
            scaledSize.height = size.height / size.width * scaledSize.width
        } else {
            scaledSize.width = size.width / size.height * scaledSize.height
        }
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? self
    }

    public func cropToSize(newSize: CGSize) -> UIImage {
        let size = self.size
        var x: CGFloat = (size.width - newSize.width) * 0.5
        var y: CGFloat = (size.height - newSize.height) * 0.5
        var tempNewSize = newSize
        if self.imageOrientation == .left
            || self.imageOrientation == .leftMirrored
            || self.imageOrientation == .right
            || self.imageOrientation == .rightMirrored {
                var temp = x
                x = y
                y = temp
                temp = tempNewSize.width
                tempNewSize.width = tempNewSize.height
                tempNewSize.height = temp
        }
        let cropRect = CGRect(
            x: x * self.scale,
            y: y * self.scale,
            width: tempNewSize.width * self.scale,
            height: tempNewSize.height * self.scale
        )
        guard let cgImage = self.cgImage else { return self }
        guard let croppedImageRef = cgImage.cropping(to: cropRect) else { return self }
        let cropped = UIImage(
            cgImage: croppedImageRef,
            scale: self.scale,
            orientation: self.imageOrientation
        )
        return cropped
    }

    public func fixImageOrientation() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
