//
//  LoginController.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    
    
    private lazy var logoImageView: UIImageView = {
        let iV = UIImageView()
        iV.contentMode = .scaleAspectFit
        iV.clipsToBounds = true
        iV.image = #imageLiteral(resourceName: "TwitterLogo")
        return iV
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textFieldName: NSLocalizedString("email_auth", comment: ""))
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textFieldName: NSLocalizedString("password_auth", comment: ""), isPassword: true)
        return view
    }()
    
    
    
    
    private let loginButton: UIButton = {
        let b = Utilities().uiButton(backgroundColor: .white, title: NSLocalizedString("logInButton_auth", comment: ""), textColor: .twitterBlue)
        b.addTarget(self, action: #selector(logInButtonTrigger), for: .touchUpInside)
        return b
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let b = Utilities().attributedButton(NSLocalizedString("dont_have_account_firstPart_auth", comment: ""), NSLocalizedString("dont_have_account_secondPart_auth", comment: ""))
        b.addTarget(self, action: #selector(sendUserToSignUpPage), for: .touchUpInside)
        return b
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func logInButtonTrigger(_ sender: UIButton){
        print(sender.currentTitle ?? "No title")
    }
    
    @objc func sendUserToSignUpPage(_ sender: UIButton){
        let controller = RegistrationControler()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            loginButton
        ])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        [logoImageView, stack, dontHaveAccountButton].forEach { view.addSubview($0) }
        
        logoImageView.centerX(inView: view,
                              topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        logoImageView.setDimensions(width: 150,
                                    height: 150)
        
        stack.anchor(top: logoImageView.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingLeft: 32, paddingRight: 32)
        dontHaveAccountButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.safeAreaLayoutGuide.rightAnchor,
                                     paddingLeft: 40,
                                     paddingRight: 40)
    }
    
    func addImageIconTo(withImage image: UIImage, to view: UIView) -> UIImageView{
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        return iv
    }
}
