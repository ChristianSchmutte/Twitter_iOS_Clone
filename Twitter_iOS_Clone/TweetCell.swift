//
//  TweetCell.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 05.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit
import SDWebImage

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
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
        guard let tweet = tweet else {return}
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.string(from: tweet.timestamp)
        infoLabel.attributedText = viewModel.userInfoText
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        
        
    }
}
