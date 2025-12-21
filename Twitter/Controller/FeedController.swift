//
//  FeedController.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 14/12/25.
//
import UIKit
import SDWebImage

private let resulIden = "Tweetcell"

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            DispatchQueue.main.async {
                self.configureLeftBarButton()
            }
        }
    }
    
    private var tweets = [Tweet]() {
        didSet {collectionView.reloadData()}
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()

    }
    
    // MARK: API
    func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: resulIden)
        
        
        let imageView = UIImageView(image: UIImage(resource: .twitterLogoBlue))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        
        let profileImageView = UIImageView()
        profileImageView.frame = CGRect(x: 2, y: 2, width: 32, height: 32)
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .systemGray4
        
        if let url = user.profileImageUrl {
            profileImageView.sd_setImage(
                with: url,
                placeholderImage: UIImage(systemName: "person.circle.fill"),
                options: [.refreshCached],
                completed: { (image, error, cacheType, url) in
                    if error != nil {
                        profileImageView.image = UIImage(systemName: "person.circle.fill")
                        profileImageView.tintColor = .systemGray3
                    }
                }
            )
        } else {
            profileImageView.image = UIImage(systemName: "person.circle.fill")
            profileImageView.tintColor = .systemGray3
        }
        
        containerView.addSubview(profileImageView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
    }
}



// MARK: EXTENSIONS

// - UICollectionViewDelegate/data source
extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resulIden, for: indexPath) as! TweetCell
        
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

// - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
