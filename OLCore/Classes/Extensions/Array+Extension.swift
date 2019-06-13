//
//  Array+Extension.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 16/05/19.
//

import Foundation

public extension Array {
    public func chunked(into size: Int) -> [[Element]] {
        if size <= 0 { return [] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

