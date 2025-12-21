//
//  MainTabController.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 14/12/25.
//

import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(resource: .newTweet), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenticateUserAndConfigureUI()
    }
    
    // MARK: API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                if self.presentedViewController == nil {
                    let nav = UINavigationController(rootViewController: LoginController())
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                }
            }
        } else {
            if viewControllers == nil || viewControllers?.isEmpty == true {
                configureViewControllers()
                configureUI()
            }
            fetchUser()
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            user = nil
            
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } catch let error {
            print("DEBUG: Error al cerrar sesión: \(error.localizedDescription)")
        }
    }

    // MARK: Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                           paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        
        if let currentUser = user {
            feed.user = currentUser
        }
        
        let nav1 = templateNavigationController(image: UIImage(resource: .homeUnselected),
                                                rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(resource: .searchUnselected),
                                                rootViewController: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(resource: .likeUnselected),
                                                rootViewController: notifications)
        
        let conversations = ConversationController()
        let nav4 = templateNavigationController(image: UIImage(resource: .icMailOutlineWhite2X1),
                                                rootViewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }

    func templateNavigationController(image: UIImage?,
                                     rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .secondarySystemBackground
        return nav
    }
}
