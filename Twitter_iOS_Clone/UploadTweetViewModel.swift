//
//  UploadTweetViewModel.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 07.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import Foundation

class UploadTweetViewModel {
    
    func uploadTweet(caption: String, completion: @escaping()->Void){
        TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                return
            }
            completion()
        }
    }
}
