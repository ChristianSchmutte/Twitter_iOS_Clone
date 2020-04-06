//
//  RegistrationControler.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit
import Firebase

class RegistrationControler: UIViewController {
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private lazy var addPhotoImageView: UIButton = {
        let b = UIButton()
        b.tintColor = .white
        b.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        b.addTarget(self, action: #selector(addPhotoButton), for: .touchUpInside)
        return b
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let b = Utilities().attributedButton("Already have an account? ", "Log In")
        b.addTarget(self, action: #selector(sendUserBackToLogIn), for: .touchUpInside)
        return b
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: NSLocalizedString("email_auth", comment: ""))
        return tf
    }()
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        return view
    }()
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: NSLocalizedString("password_auth", comment: ""), isPassword: true)
        return tf
    }()
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        return view
    }()
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: NSLocalizedString("full_name_auth", comment: ""))
        return tf
    }()
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: NSLocalizedString("username_auth", comment: ""))
        return tf
    }()
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
        return view
    }()
    
    private let signUpButton: UIButton = {
        let b = Utilities().uiButton(backgroundColor: .white, title: NSLocalizedString("signUpButton_auth", comment: ""), textColor: .twitterBlue)
        b.addTarget(self, action: #selector(signUpButtonTrigger), for: .touchUpInside)
        return b
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func sendUserBackToLogIn(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    @objc func signUpButtonTrigger(_ sender: UIButton){
        guard let profileImage = profileImage else {
            print("DEBUG: Please Select Profile image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        
        print("DEBUG: BEFORE AUTH")
        
        AuthService.shared.registerUser(credentials: AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)) { (err, ref) in
            print("BEFORR ERR HANDLING")
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("DEBUG: SIGNUP BTN PRESSED")
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
            
        }
        
        // MARK: -TODO : RegEx Email & Password with instant Feedback didFinishedTyping
        
        
    }
    @objc func addPhotoButton(_ sender: UIButton){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView, signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        [addPhotoImageView, stack, alreadyHaveAccountButton].forEach { view.addSubview($0) }
        addPhotoImageView.centerX(inView: view,
                                  topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        addPhotoImageView.setDimensions(width: 150,
                                        height: 150)
        stack.anchor(top: addPhotoImageView.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 20,
                     paddingLeft: 32, paddingRight: 32)
        alreadyHaveAccountButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.safeAreaLayoutGuide.rightAnchor,
                                        paddingLeft: 40,
                                        paddingRight: 40)
    }
    
    
    deinit {
        print("Register Deinit")
    }
    
}

extension RegistrationControler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        addPhotoImageView.layer.cornerRadius = 150 / 2
        addPhotoImageView.layer.masksToBounds = true
        addPhotoImageView.imageView?.contentMode = .scaleAspectFill
        addPhotoImageView.imageView?.clipsToBounds = true
        addPhotoImageView.layer.borderColor = UIColor.white.cgColor
        addPhotoImageView.layer.borderWidth = 3
        
        addPhotoImageView.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
}
