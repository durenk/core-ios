//
//  Array+Extension.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 16/05/19.
//

import Foundation

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
