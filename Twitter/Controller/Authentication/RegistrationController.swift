//
//  RegistrationController.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 15/12/25.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationController: UIViewController {

    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .plusPhoto), for: .normal)
        button.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
       
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attriutedButton("Already have an account? ", "Log In")
        
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(resource: .icMailOutlineWhite2X1)
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(resource: .icLockOutlineWhite2X)
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
      
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(resource: .icMailOutlineWhite2X1)
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(resource: .icLockOutlineWhite2X)
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
      
        return view
    }()
    
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full name")
        
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        
        return tf
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .secondaryLabel
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()

      
    }
    


    // MARK: - Selectors
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto(){
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func handleRegistration(){
        guard let profileImage = profileImage else {
            print("DEBUG: Please select profile image")
            return
        }
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        
       
        let credentials = AuthCredential(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.shared.registerUser(credentials: credentials) { error, ref in
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabController else {return}
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
     
        
      
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 95, height: 95)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,fullnameContainerView, usernameContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingLeft: 16, paddingRight: 16)
        
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right:  view.rightAnchor, paddingTop: 40,paddingLeft: 40, paddingBottom: 16, paddingRight: 40)
        
    }
}


// MARK: UIImagePickeControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else {return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 95/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleToFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil )
        
    }
}


#Preview{
    RegistrationController()
}
