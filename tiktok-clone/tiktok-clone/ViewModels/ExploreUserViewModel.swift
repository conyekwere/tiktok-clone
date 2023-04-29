//
//  ExploreUserViewModel.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/16/23.
//

import Foundation
import UIKit

struct ExploreUserViewModel {
    let profilePicture: UIImage?
    let username: String
    let followerCuunt: Int
    let handler: (() -> Void)
}
