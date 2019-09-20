//
//  TimeInterval+Format.swift
//  OLCore
//
//  Created by Sofyan Fradenza Adi on 20/09/19.
//

import Foundation

extension TimeInterval {
    public func convertToHumanTextFormat() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
