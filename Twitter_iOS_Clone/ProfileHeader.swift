//
//  ProfileHeader.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 07.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
}
