//
//  ExplorePostViewModel.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/16/23.
//

import Foundation
import UIKit


struct ExplorePostViewModel {
    let thumbnailImage: UIImage?
    let caption: String
    let handler: (() -> Void)
}
