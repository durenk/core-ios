//
//  UIImage+Compression.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 30/10/19.
//

import Foundation

extension UIImage {
    enum JpegQuality: CGFloat {
        case lowest = 0.0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1.0
    }

    func jpeg(_ jpegQuality: JpegQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }

    func compressTo(expectedSizeInMb: Int) -> UIImage {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress: Bool = true
        var imageData: Data?
        var compressingValue: CGFloat = 1.0
        while (needCompress && compressingValue > DefaultValue.emptyCGFloat) {
            guard let data = jpegData(compressionQuality: compressingValue) else { return self }
            if data.count < sizeInBytes {
                needCompress = false
                imageData = data
            } else {
                compressingValue -= 0.1
            }
        }
        guard let data = imageData else { return self }
        if data.count < sizeInBytes {
            return UIImage(data: data) ?? self
        }
        return self
    }
}
