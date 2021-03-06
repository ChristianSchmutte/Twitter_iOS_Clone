//
//  MainTabController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MainTabController: UITabBarController {
    
    public let viewModel = MainTabViewModel()
    
    // MARK: - Properties
    var userWhichWasWrong: User? {
        didSet{
            print("DEBUG: Did set user in main tab..")
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = self.userWhichWasWrong
        }
    }
    
    var userDict : [String : Any]? {
        didSet {
            print("DEBUG: Did set userDICT in main tab..")
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.userDict = userDict
        }
    }
    
    let actionButton: UIButton = {
        let b = UIButton(type: .system)
        b.tintColor = .white
        b.backgroundColor = .twitterBlue
        b.setImage(UIImage(named: "new_tweet"), for: .normal)
        b.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return b
    }()
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        print(viewModel.authenticateUser())
        
        authenticateUserAndConfigureUI()
        
    }
    
    // MARK: -API
    

    
    func authenticateUserAndConfigureUI(){
        if viewModel.authenticateUser() {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            viewModel.fetchUser { (fullname, username, imageURL) in
                var dict = [String : Any]()
                dict["fullname"] = fullname
                dict["username"] = username
                dict["profileImageUrl"] = imageURL
                self.userDict = dict
            }
        }
    }
    
    func logUserOut(){
        do {
            try Auth.auth().signOut()
        } catch let err {
            print("DEBUG: ERR Failed to sign out.." + err.localizedDescription)
        }
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped(_ sender: UIButton) {
        
        guard let imageUrl = userDict?["profileImageUrl"] as? URL else {return}
        let nav = UINavigationController(rootViewController: UploadTweetViewController(imageUrl: imageUrl))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    

    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0, paddingLeft: 0, paddingBottom: 64, paddingRight: 16,
            width: 56, height: 56
        )
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers(){
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNav = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        let explore = ExploreController()
        let exploreNav = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        let notifications = NotificationsController()
        let notificationsNav = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        let conversations = ConversationsController()
        let conversationsNav = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        viewControllers = [feedNav, exploreNav, notificationsNav, conversationsNav,]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .white
        return nav
    }

}
