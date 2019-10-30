//
//  UIImage+Compression.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 30/10/19.
//

import UIKit

public typealias UIImageDidCompressHandler = (_ imageData: Data?) -> Void

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

    public func compressToExpectedSize(
        inKb expectedSize: CGFloat,
        didCompress: @escaping UIImageDidCompressHandler
    ) {
        let sizeInBytes = expectedSize * 1000
        var compressingValue: CGFloat = JpegQuality.highest.rawValue
        DispatchQueue.global(qos: .userInitiated).async {
            while (true) {
                let data = self.jpegData(compressionQuality: compressingValue)
                if compressingValue <= JpegQuality.lowest.rawValue {
                    DispatchQueue.main.async {
                        didCompress(data)
                    }
                    return
                }
                if let imageData = data, CGFloat(imageData.count) < sizeInBytes {
                    DispatchQueue.main.async {
                        didCompress(data)
                    }
                    return
                }
                compressingValue -= JpegQuality.lowest.rawValue
            }
        }
    }
}
