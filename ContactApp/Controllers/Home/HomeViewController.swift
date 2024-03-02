//
//  HomeViewController.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 24/02/24.
//

import UIKit


class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var viewModal = HomeViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        initView()
    }
    
    
    
    // Mark: - Method
    func initView(){
        initNavigation()
        bindViewModal()
        viewModal.apiPostList()
    }
    
    func bindViewModal(){
        viewModal.controller = self
        viewModal.items.bind(to: self){ strongSelf,_ in
            strongSelf.tableView.reloadData()
        }
    }
    
    func initNavigation(){
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "person.fill.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Contacts"
    }
    
    func callAddViewController(){
        let vc = AddViewController(nibName: "AddViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(contact: Contact){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.contact = contact
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
       
    }
    
    // Mark: - Actions
    
    @objc func leftTapped(){
        viewModal.apiPostList()
    }
    @objc func rightTapped(){
        callAddViewController()
    }
    
    // Mark: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModal.items.value[indexPath.row]
        
        let cell = (Bundle.main.loadNibNamed("ContactTableViewCell", owner: self,options: nil)?.first as? ContactTableViewCell)!
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompliteContextualAction(forRowAt:indexPath,contact: viewModal.items.value[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt:indexPath,contact: viewModal.items.value[indexPath.row])])
    }
    
    private func makeDeleteContextualAction(forRowAt indexpath: IndexPath, contact:Contact)->UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView,complition) in
            complition(true)
            self.viewModal.apiPostDelete(contact: contact, handler: { isDeleted in
                if isDeleted{
                    self.viewModal.apiPostList()
                }
            })
        }
    }
    
    private func makeCompliteContextualAction(forRowAt indexpath: IndexPath, contact:Contact)->UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView,complition) in
            complition(true)
            self.callEditViewController(contact: contact)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModal.apiPostList()
    }
    
}
