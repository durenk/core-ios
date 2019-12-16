//
//  ViewController+Handler.swift
//  Prospeku
//
//  Created by NICKO PRASETIO on 16/12/19.
//  Copyright © 2019 Definite. All rights reserved.
//

import Foundation
import UIKit

@objc public extension UIViewController {

    private func full_present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {

        if #available(iOS 13.0, *) {
            if viewControllerToPresent.modalPresentationStyle == .automatic || viewControllerToPresent.modalPresentationStyle == .pageSheet {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }

        self.full_present(viewControllerToPresent, animated: animated, completion: completion)
    }

    @nonobjc private static let _fulllPresentationStyle: Void = {
        let instance: UIViewController = UIViewController()
        let aClass: AnyClass! = object_getClass(instance)

        let originalSelector = #selector(UIViewController.present(_:animated:completion:))
        let fullSelector = #selector(UIViewController.full_present(_:animated:completion:))

        let originalMethod = class_getInstanceMethod(aClass, originalSelector)
        let fullScreenMethod = class_getInstanceMethod(aClass, fullSelector)

        if let originalMethod = originalMethod, let fullScreenMethod = fullScreenMethod {
            if !class_addMethod(aClass, originalSelector, method_getImplementation(fullScreenMethod), method_getTypeEncoding(fullScreenMethod)) {
                method_exchangeImplementations(originalMethod, fullScreenMethod)
            } else {
                class_replaceMethod(aClass, fullSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            }
        }
    }()

    @objc static func fullPresentationStyle() {
        _ = self._fullPresentationStyle
    }
}
