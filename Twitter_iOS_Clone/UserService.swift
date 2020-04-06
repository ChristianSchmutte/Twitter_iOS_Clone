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
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid  else {
            print("DEBUG: NO USER ID...")
            return
        }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else { fatalError("Can't cast string") }
            
            let user = User(uid: uid, dictionary: dictionary)
            print(user.fullname)
            
            completion(user)
        }
    }
}
