//
//  ContactCoordinator.swift
//  OLCore
//
//  Created by Mac User on 14/10/19.
//

import UIKit
import ContactsUI

open class ContactCoordinator: Coordinator {
    public let controller: ContactViewController
    public let presenter: NavigationController
    
    public init(presenter: NavigationController, delegate: ContactControllerDelegate) {
        self.controller = ContactViewController()
        self.presenter = presenter
        self.controller.contactDelegate = delegate
    }
    
    open func start() {
        presenter.present(controller, animated: true, completion: nil)
    }
    
}


