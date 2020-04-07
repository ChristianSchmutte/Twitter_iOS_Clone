//
//  FeedViewModel.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 07.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import Foundation
import Firebase

protocol FeedViewModelDelegate: class {
    var tweetDict: [[String : Any]] { get set }
}

class FeedViewModel {
    public weak var delegate: FeedViewModelDelegate?
    private var tweets: [Tweet]? {
        didSet {
            guard let tweets = tweets else {return}
            var passDownDict = [[String : Any]]()
            for tweet in tweets {
                guard let imageUrl = tweet.user.profileImageUrl else {return}
                guard let timestamp = tweet.timestamp else {return}
                let dict : [String:Any] = [
                    "caption" : tweet.caption,
                    "fullname" : tweet.user.fullname,
                    "username" : tweet.user.username,
                    "likes" : tweet.likes,
                    "retweets" : tweet.retweetCount,
                    "timestamp" : timestamp,
                    "profileImageUrl" : imageUrl,
                    "tweetID" : tweet.tweetID
                ]
                passDownDict.append(dict)
            }
            delegate?.tweetDict = passDownDict
        }
    }
    func fetchTweets(completion: @escaping(String, String, String, Int, Int, Date, URL)->Void){
        
        guard let tweets = tweets else {return}
            
            for tweet in tweets {
                guard let imageUrl = tweet.user.profileImageUrl else {return}
                
                completion(tweet.caption,
                           tweet.user.fullname,
                           tweet.user.username,
                           tweet.likes,
                           tweet.retweetCount,
                           tweet.timestamp,
                           imageUrl)
                print("DEBUG: Tweet count is \(tweets.count) ")
            }
        
    }
    
    init(){
        
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
}
