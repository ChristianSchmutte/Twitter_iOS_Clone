//
//  UploadTweetViewController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 04.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class UploadTweetViewController: UIViewController {
    // MARK: -Properties
    
    private let profileImageUrl: URL
    private let viewModel: UploadTweetViewModel
    
    private lazy var actionButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .twitterBlue
        b.setTitle("Tweet", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.textAlignment = .center
        b.titleLabel?.font = .boldSystemFont(ofSize: 16)
        b.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        b.layer.cornerRadius = 32 / 2
        b.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return b
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let captionTextView: CaptionTextView = CaptionTextView()
    
    // MARK: -Lifecycle
    init(imageUrl: URL) {
        self.profileImageUrl = imageUrl
        self.viewModel = UploadTweetViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: -Selectors
    
    @objc func handleCancle(){
        dismiss(animated: true, completion: nil)
    }
    @objc func handleUploadTweet(){
        guard let caption = captionTextView.text else {return}
//        TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
//            if let error = error {
//                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
//                return
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
        viewModel.uploadTweet(caption: caption) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: -API
    
    // MARK: -Helpers
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        
        [stack].forEach({view.addSubview($0)})
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: profileImageUrl, completed: nil)
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
