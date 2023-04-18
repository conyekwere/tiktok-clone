//
//  PostComment.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/3/23.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date

    static func mockCommets() -> [PostComment] {
        let user = User(username: "kanyewest",
                        profilePictureURL: URL(string: "https://source.unsplash.com/random/1920x1080/?profile,headshot,woman")!,
                        identifier: UUID().uuidString)
        var comments = [PostComment]()

        let text = [
            "This is cool",
            "This is rad",
            "Im learning so much!"
        ]

        for comment in text {
            comments.append(
                PostComment(
                    text: comment,
                    user: user,
                    date: Date()
                )
            )
        }

        return comments
    }
}

