//
//  DrawerViewController.swift
//  OLCore
//
//  Created by DENZA on 20/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit
import PGDrawerTransition

open class DrawerViewController: TableViewController {
    private var drawerTransition: DrawerTransition!
    private var contentViewController: TableViewController = TableViewController()
    func drawerPresentCompletion() {}
    func drawerDismissCompletion() {}
    open var burgerImage: UIImage {
        get {
            return UIImage()
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        createDrawerTransition()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createBurgerButton()
    }

    open func constructContentViewController() -> TableViewController {
        return TableViewController()
    }

    private func createDrawerTransition() {
        contentViewController = constructContentViewController()
        drawerTransition = DrawerTransition(target: self, drawer: contentViewController)
        drawerTransition.edgeType = .left
        drawerTransition.setPresentCompletion {
            self.drawerPresentCompletion()
        }
        drawerTransition.setDismissCompletion {
            self.drawerDismissCompletion()
        }
    }

    private func createBurgerButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: burgerImage,
            style: .plain,
            target: self,
            action: #selector(showDrawer)
        )
    }

    @objc open func showDrawer() {
        drawerTransition.presentDrawerViewController(animated: true)
    }

    open func closeDrawer() {
        drawerTransition.drawer?.dismiss(animated: true, completion: nil)
        drawerTransition.dismissDrawerViewController(animated: true)
    }

    @objc open func reloadDrawerMenu() {
        contentViewController.render()
    }
}
