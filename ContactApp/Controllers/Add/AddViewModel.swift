//
//  AddViewModel.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 02/03/24.
//

import Foundation

class AddViewModal{
    var controller : BaseViewController!
    
    func apiPostCreate(contact:Contact,completion: @escaping (Bool) -> Void){
        controller.showProgres()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(contact: contact), handler: {respons in
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
