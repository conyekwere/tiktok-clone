//
//  HapticsManager.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/26/23.
//

import Foundation
import UIKit

/// Object that deals with haptic feedback
final class HapticsManager {
    
    public static let shared = HapticsManager()
    
    private init() {}
    
    
    //Mark: - Public
    
    public func vibrateForSelection(){
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
