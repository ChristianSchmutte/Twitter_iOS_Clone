//
//  UserService.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 04.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid  else {
            print("DEBUG: NO USER ID...")
            return
        }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print("DEBUG: snapshot is: \(snapshot)")
            guard let dictionary = snapshot.value as? [String : AnyObject] else { fatalError("Can't cast string") }
            
            guard let username = dictionary["username"] as? String else {print("DEBUG: unable to reach username as string");return}
            print("DEBUG: username is: \(username)")
        }
    }
}
