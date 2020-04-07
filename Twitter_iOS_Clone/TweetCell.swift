//
//  TweetCell.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 05.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit
import SDWebImage

protocol TweetCellDelegate: class {
    func handleProfileImageTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
//    var tweet: Tweet? {
//        didSet {
////            configure()
//
//        }
//    }
    weak var delegate: TweetCellDelegate?
    
    var tweetDict: [String:Any]? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "This is a caption"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecylce
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton,
                                                         likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.distribution = .fillProportionally
        actionStack.spacing = 72
        
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        
        [profileImageView, stack, actionStack, underlineView].forEach({addSubview($0)})
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8)
        
        infoLabel.text = "Homer Simpson @Donut"
        
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             right: rightAnchor, height: 1)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor,
                     right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleProfileImageTapped(){
        delegate?.handleProfileImageTapped(self)
    }
    
    @objc func handleCommentTapped(){
        
    }
    @objc func handleRetweetTapped(){
        
    }
    @objc func handleLikeTapped(){
        
    }
    @objc func handleShareTapped(){
        
    }
    
    // MARK: - Helpers
    
    func configure(){
        
        guard let tweetDict = tweetDict else {return}
        guard let tweetCaption = tweetDict["caption"] as? String else {return}
        guard let tweetFullname = tweetDict["fullname"] as? String else {return}
        guard let tweetUsername = tweetDict["username"] as? String else {return}
        guard let tweetImageUrl = tweetDict["profileImageUrl"] as? URL else {return}
        guard let tweetTimestamp = tweetDict["timestamp"] as? Date else {return}
        
        let now = Date()
        
        guard let date = dateFormatter.string(from: tweetTimestamp, to: now) else { return }
        var userInfoText: NSAttributedString {
            let title = NSMutableAttributedString(string: tweetFullname, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            title.append(NSAttributedString(string: " @\(tweetUsername) ",
                attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                             NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
            title.append(NSAttributedString(string: "・ \(date)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
            return title
            

        }
        
        captionLabel.text = tweetCaption
        
        infoLabel.attributedText = userInfoText
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: tweetImageUrl, completed: nil)
        
        
    }
}
