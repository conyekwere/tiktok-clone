//
//  PostModel.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/26/23.
//

import Foundation


struct PostModel{
    let identifier: String
    let user: User
    var fileName: String = ""
    var caption: String = ""

    var isLikedByCurrentUser = false
    

    
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(
                identifier: UUID().uuidString,
                user: User(
                    username: "madebychima",
                    profilePictureURL: URL(string: "https://source.unsplash.com/random/1920x1080/?profile,headshot,man,african")!,
                    identifier: UUID().uuidString
                )
            )
            posts.append(post)
        }
        return posts
    }

    
    
}
