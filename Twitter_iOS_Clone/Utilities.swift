//
//  Utilities.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let iv = UIImageView(image: image)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        
        [iv, textField, dividerView].forEach{ view.addSubview($0 ) }
        
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingLeft: 8, paddingBottom: 8)
        
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
        paddingLeft: 8, paddingRight: 8)
        dividerView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String, isPassword: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.isSecureTextEntry = isPassword ? true : false
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.returnKeyType = .done
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        
        
        return tf
    }
    
    func uiButton(backgroundColor: UIColor, title: String, textColor: UIColor) -> UIButton {
        let b = UIButton()
        b.backgroundColor = backgroundColor
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.setTitleColor(textColor, for: .normal)
        b.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        b.layer.cornerRadius = 5
        return b
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let b = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes:
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes:
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor : UIColor.white
        ]))
        b.setAttributedTitle(attributedTitle, for: .normal)
        return b
    }
    
    deinit {
        print("Utilities deinit")
    }
}
