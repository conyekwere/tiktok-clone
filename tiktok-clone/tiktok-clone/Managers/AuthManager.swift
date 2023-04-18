//
//  AuthManager.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/26/23.
//

import Foundation
import FirebaseAuth

/// Manager responsible for signing in, up, and oout
final class AuthManager {
    
    
    public static let shared = AuthManager()
    
    private init() {}
    
    //Mark: - Public
    
    enum SignInMethod{
        case email, facebook , google
    }
    /// signin Firebase User
    public func SignInUser(with method: SignInMethod, completion: @escaping (Bool) -> Void){
                do {
                    try Auth.auth().signOut()
                    completion(true)
                    return
                }
                catch{
                    print(error)
                    completion(false)
                    return
                }
    }
    
    /// signout Firebase User
    
    public func SignOutUser(completion: @escaping (Bool) -> Void){
                do {
                    try Auth.auth().signOut()
                    completion(true)
                    return
                }
                catch{
                    print(error)
                    completion(false)
                    return
                }
    }
    
    
    public func registerNewUser(username: String, email: String, password: String,completion: @escaping (Bool) -> Void){
        
        
        /*
         - check if username is available
         - check if email is available
         */
        
        
    }

    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if  let email = email {
            Auth.auth().signIn(withEmail: email, password: password){
                authResult, error in guard authResult != nil,error == nil else{
                    completion(false)
                    return
                    // if error
                    
                }
                completion(true)
            }
        }
        else if let username = username {
            // username login
            
            print(username)
            
        }
        
    }
    
        
    
}
