//
//  EditViewModel.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 02/03/24.
//

import Foundation

class EditViewModal{
    var controller : BaseViewController!
    
    func apiPostUpdate(contact: Contact,completion: @escaping (Bool) -> Void){
        controller.showProgres()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + contact.id!, params: AFHttp.paramsPostUpdate(contact: contact), handler: {respons in
            self.controller.hideProgres()
            switch respons.result{
            case .success:
                print(respons.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
        
    }
}
