//
//  Data.swift
//  hn
//
//  Created by Preet Parekh on 29/03/21.
//

import SwiftUI

struct Post: Codable, Identifiable {
    var id: Int;
    var type: String;
    var title: String
    var url: String?
    var by: String?
}

/**
 This code can be made a lot more efficient
 */
class Api {
    func getNewPosts(completion: @escaping ([Post]) -> ()) {
        var posts: Array<Post> = [Post]()
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let resultIDs = try! JSONDecoder().decode([Int].self, from: data!)
            let resultIDsSlice = resultIDs[0...10]
            for i in resultIDsSlice {
                let _url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(i).json")
                URLSession.shared.dataTask(with: _url!) { (data, _, _) in
                    let result = try! JSONDecoder().decode(Post.self, from: data!)
                    print(result)
                    posts.append(result)
                    if(result.id == resultIDsSlice.last) {
                        DispatchQueue.main.async {
                            completion(posts)
                        }
                    }
                }.resume()
            }
        }.resume()
    }
}
