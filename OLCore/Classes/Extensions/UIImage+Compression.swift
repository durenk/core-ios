//
//  UIImage+Compression.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 30/10/19.
//

import UIKit

extension UIImage {
    public enum JpegQuality: CGFloat {
        case lowest = 0.1
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1.0
    }

    public func jpeg(_ jpegQuality: JpegQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }

    public func compressTo(expectedSizeInKb: CGFloat) -> Data? {
        let sizeInBytes = expectedSizeInKb * 1000
        var compressingValue: CGFloat = JpegQuality.highest.rawValue
        while (true) {
            let data = jpegData(compressionQuality: compressingValue)
            if compressingValue <= JpegQuality.lowest.rawValue {
                return data
            }
            guard let imageData = data else {
                return data
            }
            if CGFloat(imageData.count) < sizeInBytes {
                return imageData
            }
            compressingValue -= JpegQuality.lowest.rawValue
        }
    }

    public func compressTo(expectedSizeInKb: CGFloat) -> UIImage {
        guard let data = compressTo(expectedSizeInKb: expectedSizeInKb) else { return self }
        return UIImage(data: data) ?? self
    }
}
