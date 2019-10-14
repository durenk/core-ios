//
//  ContactViewController.swift
//  DLRadioButton
//
//  Created by Mac User on 14/10/19.
//

import UIKit
import ContactsUI

open class ContactViewController: ViewController, CNContactPickerDelegate {
    private var contactPicker: CNContactPickerViewController = CNContactPickerViewController()
    open weak var contactDelegate: ContactControllerDelegate?
    
    override open func loadView() {
        super.loadView()
        contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    private func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        
        if let phone = contactProperty.value as? CNPhoneNumber {
             self.contactDelegate?.phoneNumberDidSelect(contactName: contactName, phone: phone.stringValue)
        }
    }
    
    private func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

