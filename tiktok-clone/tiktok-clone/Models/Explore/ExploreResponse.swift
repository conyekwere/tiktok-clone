//
//  ExploreResponse.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/27/23.
//

import Foundation

struct ExploreResponse: Codable {
    let banners: [Banner]
    let trendingPosts: [Post]
    let creators: [Creator]
    let recentPosts: [Post]
    let hashtags: [Hashtag]
    let popular: [Post]
    let recommended: [Post]
}
