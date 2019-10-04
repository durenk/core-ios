//
//  ViewController.swift
//  OLCore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    private var foregroundObserver: NSObjectProtocol?
    open var didLoadData: Bool = false
    open var navigationBarStyle: UIBarStyle { get { return UIBarStyle.default } }
    open var navigationBarColor: UIColor { get { return CoreStyle.Color.navigationBackground } }
    open var navigationBarTintColor: UIColor { get { return CoreStyle.Color.navigationText } }
    open var closeButtonPosition: LayoutPosition { get { return .none } }
    open var closeButton: UIBarButtonItem {
        get {
            return UIBarButtonItem(image: CoreStyle.Image.navigationCloseButton, style: .plain, target: self, action: #selector(closeButtonPressed))
        }
    }
    open var backButton: UIBarButtonItem {
        get {
            return UIBarButtonItem(image: CoreStyle.Image.navigationBackButton, style: .plain, target: self, action: #selector(backButtonPressed))
        }
    }
    open func load() {}
    open func loadMore() {}

    override open func viewDidLoad() {
        super.viewDidLoad()
        SizeHelper.calculateWindowSize(
            navigationController: navigationController,
            tabBarController: tabBarController
        )
        customizeNavigationController()
        stylingNavigation()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stylingNavigation()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CoreConfig.TableViewController.isAutoRenderOnEveryViewWillAppear {
            setupForegroundObserver()
        }
        hideKeyboardWhenTappedAround()
        if !didLoadData {
            load()
        }
        didLoadData = true
        DeeplinkManager.instance.checkIncomingUrl()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeForegroundObserver()
    }

    open func viewWillEnterForeground() {
        DispatchQueue.main.async {
            self.viewWillAppear(true)
        }
    }

    private func removeForegroundObserver() {
        guard let foregroundObserver = foregroundObserver else { return }
        NotificationCenter.default.removeObserver(foregroundObserver)
    }

    private func setupForegroundObserver() {
        foregroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main
        ) { [unowned self] notification in
            self.viewWillEnterForeground()
        }
    }

    open func stylingNavigation() {
        guard let navigation = navigationController else { return }
        navigation.navigationBar.isTranslucent = false
        if navigation.view.backgroundColor == UIColor.clear { return }
        navigation.setNavigationBarColor(navigationBarColor)
        navigation.navigationBar.shadowImage = UIColor.gray.withAlphaComponent(0.2).convertToImage()
        navigation.navigationBar.barStyle = navigationBarStyle
        navigation.navigationBar.tintColor = navigationBarTintColor
    }

    open func resetNavigationStack() {
        navigationController?.viewControllers = [self]
        navigationItem.leftBarButtonItems = nil
        navigationItem.setHidesBackButton(true, animated: false)
    }

    open func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    open func getNavigationBarHeight() -> CGFloat {
        return CGFloat(navigationController?.navigationBar.frame.size.height ?? 0.0)
    }

    @objc open func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc open func backButtonPressed() {
        guard let navigation = navigationController else { return }
        navigation.popViewController(animated: true)
    }

    @objc open func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    open func customizeNavigationController() {
        guard let navigation = navigationController else { return }
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CoreStyle.Color.navigationText, NSAttributedString.Key.font: CoreStyle.Font.navigationTitle]
        navigationItem.leftBarButtonItems = leftBarButtonItems()
        navigationItem.rightBarButtonItems = rightBarButtonItems()
    }

    open func leftBarButtonItems() -> [UIBarButtonItem] {
        var buttons = [UIBarButtonItem]()
        guard let navigation = navigationController else { return buttons }
        if navigation.viewControllers.count > 1 {
            buttons.append(backButton)
        } else if closeButtonPosition == .left {
            buttons.append(closeButton)
        }
        return buttons
    }

    open func rightBarButtonItems() -> [UIBarButtonItem] {
        var buttons = [UIBarButtonItem]()
        guard let navigation = navigationController else { return buttons }
        if navigation.viewControllers.count == 1 && closeButtonPosition == .right {
            buttons.append(closeButton)
        }
        return buttons
    }

    open func moveTabBarToController(_ controllerClass: AnyClass) {
        guard let tabBar = self.tabBarController as? TabBarNavigationController else { return }
        tabBar.moveToController(controllerClass.self)
    }

    open func isPresenting() -> Bool {
        guard let viewIfLoaded = self.viewIfLoaded else { return false }
        return viewIfLoaded.window != nil
    }

    open func setBackground(image: UIImage) {
        let backgroundView = UIImageView(frame: view.bounds)
        backgroundView.image = image
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
    }
}


extension UIColor {
    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        guard let currentContext = ctx else { return UIImage() }
        currentContext.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
