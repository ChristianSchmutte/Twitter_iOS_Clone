//
//  FeedController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit
import SDWebImage

let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController, FeedViewModelDelegate {
    
    
    // MARK: - Properties
    var user: User? {
        didSet{
//            configureLeftBarButton()
        }
    }
    var viewModel = FeedViewModel()  // = {
//        didSet {
//            viewModel?.fetchTweets(completion: { (caption, fullname, username, likes, retweets, timestamp, imageUrl) in
//                let dict : [String:Any] = [
//                    "caption" : caption,
//                    "fullname" : fullname,
//                    "username" : username,
//                    "timestamp" : timestamp,
//                    "likes" : likes,
//                    "retweets" : retweets,
//                    "profileImageUrl" : imageUrl
//                ]
//                print("DEBUG: Have completed fetching")
//                self.cellCollection.append(dict)
//            })
//        }
//    }()
    var tweetDict : [[String : Any]] = [[String : Any]]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var username: String?
    private var fullname: String?
    private var profileImageUrl: URL?
    public var userDict: [String:Any]? {
        didSet {
            print("DEBUG: Did set userDICT in FEED tab..")
            guard let username = userDict?["username"]! as? String else {return}
            guard let fullname = userDict?["fullname"]! as? String else {return}
            guard let imageUrl = userDict?["profileImageUrl"]! as? URL else {return}
            self.username = username
            self.fullname = fullname
            profileImageUrl = imageUrl
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.delegate = self as FeedViewModelDelegate
        
    }
    
    // MARK: - API
    
    func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    
    

    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    func configureLeftBarButton(){
//        guard let user = user else { return }
        let profileImageView = UIImageView()
//        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.sd_setImage(with: profileImageUrl) { (image, error, wasRetrieved, url) in
            if let error = error {
                print("Error Loading image: \(error.localizedDescription)")
                return
            }
            
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

// MARK: - UICollectionViewDelegate/ DataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tweetDict.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        guard let tweetDict = tweetDict[indexPath.row] as? [String:Any] else { fatalError("DEBUG: No tweet dict") }
        cell.delegate = self as TweetCellDelegate
        cell.tweetDict = tweetDict
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension FeedController: TweetCellDelegate {
    func handleProfileImageTapped(_ cell: TweetCell) {
        guard let tweetID = cell.tweetDict!["tweetID"] as? String else {return}
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
}
