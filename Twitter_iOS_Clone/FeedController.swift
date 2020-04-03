//
//  FeedController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
         configureUI()
        
    }
    

    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}


