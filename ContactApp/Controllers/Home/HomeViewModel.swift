//
//  HomeViewModel.swift
//  ContactApp
//
//  Created by A'zamjon Abdumuxtorov on 02/03/24.
//

import Foundation
import Bond

class HomeViewModal{
    var controller : BaseViewController!
    let items = Observable<[Contact]>([])
    
    func apiPostList(){
        controller.showProgres()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: {respons in
            self.controller.hideProgres()
            switch respons.result{
            case .success:
                let post = try! JSONDecoder().decode([Contact].self, from: respons.data!)
                self.items.value = post
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostDelete(contact:Contact,handler: @escaping (Bool)-> Void){
        controller.showProgres()
        AFHttp.del(url: AFHttp.API_POST_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: {respons in
            self.controller.hideProgres()
            switch respons.result{
            case .success:
                print(respons.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
