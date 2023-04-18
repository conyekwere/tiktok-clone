//
//  ExploreUserViewModel.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/16/23.
//

import Foundation
struct ExploreUserViewModel {
    let profilePictureURL: URL?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}
