//
//  UIConfigureExtension.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureUI(backgroundColor: UIColor, navigationTitle: String){
        view.backgroundColor = backgroundColor
        navigationItem.title = navigationTitle
    }
    
    func configureActionButton(image: UIImage, action: Selector) -> UIButton {
        let b = UIButton(type: .system)
        b.tintColor = .white
        b.backgroundColor = .blue
        b.setImage(image, for: .normal)
        b.addTarget(self, action: action, for: .touchUpInside)
        return b
    }
}
