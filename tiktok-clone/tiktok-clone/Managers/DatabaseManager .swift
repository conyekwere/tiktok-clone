//
//  DatabaseManager .swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/26/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {

    public static let shared = DatabaseManager()
    
    
    private let database = Database.database().reference()
    private init() {}
    
    
    // Public
    
    
    public func getAllUsers(completion: ([String]) -> Void ){
        
        
    }
    
   
}
