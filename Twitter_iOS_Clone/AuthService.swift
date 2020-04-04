//
//  AuthService.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 03.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit.UIImage
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, withPassword password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void){
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            if let err = error {
                fatalError(err.localizedDescription)
            }
            storageRef.downloadURL { (url, err) in
                guard let profileImageUrl = url?.absoluteString else { fatalError("No imageURL") }
                print(profileImageUrl)
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": email,
                                  "username" : username,
                                  "fullname" : fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    print("Reached Callback hell.....................")
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
