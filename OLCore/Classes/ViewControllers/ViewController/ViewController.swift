//
//  ViewController.swift
//  OLCore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    open var didLoadData: Bool = false
    open var navigationBarStyle: UIBarStyle { get { return UIBarStyle.default } }
    open var navigationBarColor: UIColor { get { return CoreStyle.Color.NavigationBackground } }
    open var navigationBarTintColor: UIColor { get { return CoreStyle.Color.NavigationText } }
    open var closeButtonEnabled: Bool { get { return false } }
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
        hideKeyboardWhenTappedAround()
        if !didLoadData {
            load()
        }
        didLoadData = true
        DeeplinkManager.instance.checkIncomingUrl()
    }

    private func stylingNavigation() {
        guard let navigation = navigationController else { return }
        navigation.setNavigationBarColor(navigationBarColor)
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
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: CoreStyle.Font.NavigationTitle]
        navigationItem.leftBarButtonItems = leftBarButtonItems()
        navigationItem.rightBarButtonItems = rightBarButtonItems()
    }

    open func leftBarButtonItems() -> [UIBarButtonItem] {
        var buttons = [UIBarButtonItem]()
        guard let navigation = navigationController else { return buttons }
        if navigation.viewControllers.count > 1 {
            let backButton = UIBarButtonItem(image: CoreStyle.Image.NavigationBackButton, style: .plain, target: self, action: #selector(backButtonPressed))
            buttons.append(backButton)
        } else if closeButtonEnabled {
            let closeButton = UIBarButtonItem(image: CoreStyle.Image.NavigationCloseButton, style: .plain, target: self, action: #selector(closeButtonPressed))
            buttons.append(closeButton)
        }
        return buttons
    }

    open func rightBarButtonItems() -> [UIBarButtonItem] {
        return [UIBarButtonItem]()
    }

    open func moveTabBarToController(_ controllerClass: AnyClass) {
        guard let tabBar = self.tabBarController as? TabBarNavigationController else { return }
        tabBar.moveToController(controllerClass.self)
    }

    open func isPresenting() -> Bool {
        guard let viewIfLoaded = self.viewIfLoaded else { return false }
        return viewIfLoaded.window != nil
    }
}
