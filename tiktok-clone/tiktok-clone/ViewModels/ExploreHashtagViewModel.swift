//
//  ExploreHashtagViewModel.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/16/23.
//

import Foundation
import UIKit

struct ExploreHashtagViewModel {
    let text: String
    let icon: UIImage?
    let count: Int //number of post with the tag
    let handler: (() -> Void)
}

