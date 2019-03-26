//
//  NavigationController.swift
//  OLCore
//
//  Created by Steven Tiolie on 11/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    open func getFirstViewController() -> ViewController {
        if viewControllers.count < 1 { return ViewController() }
        guard let firstVC = viewControllers.first as? ViewController else { return ViewController() }
        return firstVC
    }
}
