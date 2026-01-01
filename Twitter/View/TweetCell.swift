//
//  TweetCell.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 20/12/25.
//

import UIKit


protocol TweetCellDelegate: AnyObject {
    func handleProfileImageeTapped(_ cell: TweetCell)
    func handleReplydTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell{
    
    //MARK: PROPERTIES
    
    var tweet: Tweet?{
        didSet {configure()}
    }
    
    weak var delegate: TweetCellDelegate?
    
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 24
        iv.backgroundColor = .twitterBlue //quitar
        
        let  tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.numberOfLines = 0
        label.text = "Some test caption"
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .comment), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .retweet), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .like), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handlelikeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .share), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private let infoLabel = UILabel()
        
   
    
    // MARK: LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8
                                
        )
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor,
                     right: rightAnchor, paddingLeft: 12, paddingRight: 12
        )
        
        
        infoLabel.text = "Theo James @theeo"
        infoLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             right: rightAnchor, height: 1
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SELECTORS
    
    @objc func handleProfileImageTapped(){
    
        delegate?.handleProfileImageeTapped(self)
    }
    
    
    @objc func handleCommentTapped(){
        delegate?.handleReplydTapped(self)
    }
    
    @objc func handleRetweetTapped(){
        
    }
    
    @objc func handlelikeTapped(){
        
    }
    @objc func handleShareTapped(){
        
    }
    
   
    
    
    // MARK: HELPERS
    
    func configure(){
        guard let tweet = tweet else {return}
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        infoLabel.attributedText = viewModel.userInfoText
        
    }
    
    
}
