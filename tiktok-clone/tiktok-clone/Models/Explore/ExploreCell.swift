//
//  ExploreCell.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 4/15/23.
//

import Foundation
import UIKit


enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hastag(viewModel: ExploreHashtagViewModel)
    case user(viewModel: ExploreUserViewModel)
}






