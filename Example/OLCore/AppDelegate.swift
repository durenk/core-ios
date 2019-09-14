//
//  AppDelegate.swift
//  OLCore
//
//  Created by fradenza on 03/12/2019.
//  Copyright (c) 2019 fradenza. All rights reserved.
//

import UIKit
import OLCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        initHelper()
        initMainWindow()
        return true
    }

    func initMainWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = DemoViewController()
        window!.makeKeyAndVisible()
    }

    private func initHelper() {
        SizeHelper.calculateScreenSize()
        SizeHelper.calculateWindowSize(navigationController: nil, tabBarController: nil)
    }
}
