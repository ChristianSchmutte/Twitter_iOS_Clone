//
//  RegistrationControler.swift
//  Twitter_iOS_Clone
//
//  Created by Christian Schmutte on 02.04.20.
//  Copyright © 2020 Christian Schmutte. All rights reserved.
//

import UIKit

class RegistrationControler: UIViewController {
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()

    
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
    private let emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textFieldName: NSLocalizedString("email_auth", comment: ""))
        
        return view
    }()
    private let passwordContainer: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textFieldName: NSLocalizedString("password_auth", comment: ""), isPassword: true)
        return view
    }()
    private let fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textFieldName: NSLocalizedString("full_name_auth", comment: ""))
        return view
    }()
    private let usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textFieldName: NSLocalizedString("username_auth", comment: ""))
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
        print("SING UP")
    }
    @objc func addPhotoButton(_ sender: UIButton){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainer, fullNameContainerView, usernameContainerView, signUpButton])
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
