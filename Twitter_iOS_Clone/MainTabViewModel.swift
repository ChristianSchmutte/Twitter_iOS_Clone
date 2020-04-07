//
//  MainTabViewModel.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 07.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Firebase

class MainTabViewModel {
    private var user: User? {
        didSet {
            print("DEBUG: User set in Main Tab View Model...")
        }
    }
    
    func fetchUser(completion: @escaping(String,String,URL?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid ) { user in
            self.user = user
            
            completion(user.fullname, user.username, user.profileImageUrl)
        }
    }
    func authenticateUser() -> Bool{
        
        return Auth.auth().currentUser == nil
    }
}
