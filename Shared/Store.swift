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
    @Published  var pastPosts = [Post]()
    @Published  var showPosts = [Post]()
    
    var placeholderPosts = [
        Post(id: 1, type: "test", title: "This is a test post", url: "https://google.com", by: "test 123"),
        Post(id: 2, type: "test", title: "This is a test post with longr words", url: "https://google.com", by: "test"),
        Post(id: 3, type: "test", title: "This is a test", url: "https://google.com", by: "test 123"),
        Post(id: 4, type: "test", title: "This is a test post with a lot of lot of words", url: "https://google.com", by: "test 1235869io with a test"),
        Post(id: 5, type: "test", title: "This is a test post", url: "https://google.com", by: "test 123"),
        Post(id: 6, type: "test", title: "This is a test post", url: "https://google.com", by: "test 123"),
        Post(id: 7, type: "test", title: "This is a test post", url: "https://google.com", by: "test 123"),
        Post(id: 8, type: "test", title: "This", url: "https://google.com", by: "test 123 is a test for a test"),
        Post(id: 9, type: "test", title: "This is a test post with", url: "https://google.com", by: "test 123"),
        Post(id: 10, type: "test", title: "This is a test", url: "https://google.com", by: "test 1239-9")
    ].shuffled()
    
    
    func getNewPosts() {
        api.getNewPosts { (posts) in
            self.newPosts.append(contentsOf: posts)
        }
    }
    
    func getPastPosts() {
        api.getPastPosts { (posts) in
            self.pastPosts.append(contentsOf: posts)
        }
    }
    
    func getShowPosts() {
        api.getShowPosts { (posts) in
            self.showPosts.append(contentsOf: posts)
        }
    }
    
    func refresh() {
        newPosts = []
        api.getNewPosts { (posts) in
            self.newPosts.append(contentsOf: posts)
        }
    }
}
