//
//  AddViewController.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 24/02/24.
//

import UIKit

class AddViewController: BaseViewController {

    @IBOutlet weak var nameFild: UITextField!
    @IBOutlet weak var phoneFild: UITextField!
    var viewModal = AddViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModal()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModal() {
        viewModal.controller = self
    }

    @IBAction func saveButton(_ sender: Any) {
        let contact = Contact(name: nameFild.text!, phone: phoneFild.text!)
        viewModal.apiPostCreate(contact: contact) { [weak self] success in
            guard success else { return }
            self?.navigationController?.popViewController(animated: true)
        }
    }

    
}
