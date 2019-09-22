//
//  UIImage+Extension.swift
//  OLCore
//
//  Created by DENZA on 03/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UIImage {
    public func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return newImage
    }

    public func cropToSize(newSize: CGSize) -> UIImage {
        let size = self.size
        var originX: CGFloat!
        var originY: CGFloat!
        originX = (size.width - newSize.width) * 0.5
        originY = (size.height - newSize.height) * 0.5
        var tempNewSize = newSize
        if self.imageOrientation == .left
            || self.imageOrientation == .leftMirrored
            || self.imageOrientation == .right
            || self.imageOrientation == .rightMirrored {
            var temp = originX
            originX = originY
            originY = temp
            temp = tempNewSize.width
            tempNewSize.width = tempNewSize.height
            tempNewSize.height = temp!
        }
        let cropRect = CGRect(
            x: originX * self.scale,
            y: originY * self.scale,
            width: tempNewSize.width * self.scale,
            height: tempNewSize.height * self.scale
        )
        let croppedImageRef = self.cgImage!.cropping(to: cropRect)
        let cropped = UIImage(cgImage: croppedImageRef!, scale: self.scale, orientation: self.imageOrientation)
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
