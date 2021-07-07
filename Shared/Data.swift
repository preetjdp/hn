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
    func getPosts(IDs: Array<Int>, completion: @escaping ([Post]) -> ()) {
        var posts: Array<Post> = [Post]()
        
        for i in IDs {
            guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(i).json") else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let result = try! JSONDecoder().decode(Post.self, from: data!)
                print(result)
                posts.append(result)
                if(result.id == IDs.last) {
                    DispatchQueue.main.async {
                        completion(posts)
                    }
                }
            }.resume()
        }
    }
    
    func getNewPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let resultIDs = try! JSONDecoder().decode([Int].self, from: data!)
            let resultIDsSlice = Array(resultIDs[0...10])
            self.getPosts(IDs: resultIDsSlice) { (posts) in
                completion(posts)
            }
        }.resume()
    }
    
    func getPastPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/paststories.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let resultIDs = try! JSONDecoder().decode([Int].self, from: data!)
            let resultIDsSlice = Array(resultIDs[0...10])
            self.getPosts(IDs: resultIDsSlice) { (posts) in
                completion(posts)
            }
        }.resume()
    }
    
    func getShowPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/showstories.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let resultIDs = try! JSONDecoder().decode([Int].self, from: data!)
            let resultIDsSlice = Array(resultIDs[0...10])
            self.getPosts(IDs: resultIDsSlice) { (posts) in
                completion(posts)
            }
        }.resume()
    }
}
