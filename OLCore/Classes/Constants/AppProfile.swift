//
//  AppProfile.swift
//  OLCore
//
//  Created by CALISTA on 06/11/19.
//

import Foundation

public struct AppProfile {
    public static var appName: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? DefaultValue.emptyString
        }
    }
    public static var versionName: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? DefaultValue.emptyString
        }
    }
    public static var buildNumber: Int {
        get {
            return Int(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? DefaultValue.emptyString) ?? DefaultValue.emptyInt
        }
    }
    public static var deviceId: String {
        get {
            guard let identifier = UIDevice.current.identifierForVendor else { return DefaultValue.emptyString }
            return identifier.uuidString
        }
    }
}
