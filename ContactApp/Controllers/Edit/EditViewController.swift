//
//  EditViewController.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 24/02/24.
//

import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var nameLb: UITextField!
    @IBOutlet weak var phoneLb: UITextField!
    var contact: Contact?
    var viewModal = EditViewModal()
    
    
    override func viewDidLoad() {
        bindViewModal()
        super.viewDidLoad()
        if let contact = contact {
            nameLb.text = contact.name
            phoneLb.text = contact.phone
        }
        
    }
    
    func bindViewModal() {
        viewModal.controller = self
    }
    
    @IBAction func UpdateButton(_ sender: Any) {
        guard let newName = nameLb.text, let newPhone = phoneLb.text else {
            return
        }
        
        if var contact = contact {
            contact.name = newName
            contact.phone = newPhone
            viewModal.apiPostUpdate(contact: contact) { [weak self] success in
                guard success else { return }
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

