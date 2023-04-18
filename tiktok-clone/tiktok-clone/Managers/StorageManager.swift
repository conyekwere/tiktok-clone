//
//  StorageManager.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import Foundation
import FirebaseStorage

/// Manager  object that deals with firebase storage
final class StorageManager {
    public static let shared = StorageManager()
    
    
    private let storage = Storage.storage().reference()
    private init() {}
    
    
    
    // Public
    
    public func getVideoURL(with identifier: String ,completion: (URL) -> Void ){
        
        
    }
    
    public func uploadVideoURL(from url: URL ,completion: (URL) -> Void ){
        
        
    }
        
        
}
