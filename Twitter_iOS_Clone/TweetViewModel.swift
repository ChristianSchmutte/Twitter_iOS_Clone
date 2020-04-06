//
//  TweetViewModel.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 05.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//


import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    var profileImageUrl: URL? {
        return tweet.user.profileImageUrl
    }
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)",
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                         NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        return title
        
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
