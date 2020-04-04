//
//  Constants.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 03.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
