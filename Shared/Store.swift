//
//  Store.swift
//  hn
//
//  Created by Preet Parekh on 30/03/21.
//

import Foundation
import SwiftUI

class Store: ObservableObject {
    let api: Api = Api()
    @Published  var newPosts = [Post]()
    
    
    func getNewPosts() {
        api.getNewPosts { (posts) in
            self.newPosts.append(contentsOf: posts)
        }
    }
}
