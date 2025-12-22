//
//  ProfileHeader.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 20/12/25.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject{
    func handleDismissal()
    func handleEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView{
    
    //MARK: Properties
    var user: User?{
        didSet{configure()}
    }
    
    weak var delegate: ProfileHeaderDelegate?
    private let filterBar = ProfileFilterView()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor,paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setImage(UIImage(resource: .baselineArrowBackWhite24Dp), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    //profile image
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.systemBackground.cgColor
     
        iv.layer.borderWidth = 4
        return iv
    }()
    
     lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    //bio
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.text = "Hey, what's up im Theo, im actor and i live in LA"
        return label
    }()
    
    //city label
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "⚲ Laurel Canyon, CA"
        label.textColor = .gray
        return label
    }()
    
    //name
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.text = "Theo James"
        return label
    }()
    
    //username
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
//        label.text = "@theo1"
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.text = "100 Following"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "1.5K Followers"
        label.textColor = .gray
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    
    
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterBar.delegate = self //set delegate
        
        //container constraints
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        //profile constraints
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        //edit constraints
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
        editProfileFollowButton.setDimensions(width: 100, height: 36)
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        
        //user detail stack
        let userDetailStack = UIStackView(arrangedSubviews: [fullnameLabel
                                                             , usernameLabel,
                                                             bioLabel, cityLabel])
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        
        addSubview(userDetailStack)
        userDetailStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        
        
        //follow stack
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followerLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        addSubview(followStack)
        followStack.anchor(top: userDetailStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        
        //filter bar
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        //underline
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SELECTORS
    @objc func handleDismissal(){
        delegate?.handleDismissal()
    }
    
    @objc func handleEditProfileFollow(){
        delegate?.handleEditProfileFollow(self)
    }
    
    @objc func handleFollowersTapped(){
        
    }
    @objc func handleFollowingTapped(){
        
    }
    
    //MARK: Helpers
    func configure(){
        guard let user = user else {return}

        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        followingLabel.attributedText = viewModel.followingString
        followerLabel.attributedText = viewModel.followerString
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
}

//MARK: ProfileFilterViewDelegate
extension ProfileHeader: ProfileFilterViewDelegate{
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else {return}
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
    
    
}
