//
//  ExploreManager.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/26/23.
//

import Foundation
import UIKit

/// Delegate interface to notify manager events
protocol ExploreManagerDelegate: AnyObject {
    /// Notify a view controller should be pushed
    /// - Parameter vc: The view controller to present
    func pushViewController(_ vc: UIViewController)
    /// Notify a hashtag element was tapped
    /// - Parameter hashtag: The hashtag taht was tapped
    func didTapHashtag(_ hashtag: String)
}

/// Manager that handles explore view content
final class ExploreManager {
}
