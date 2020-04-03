//
//  MainTabController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
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

        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped(_ sender: UIButton) {
        print(123)
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
        let feed = FeedController()
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
