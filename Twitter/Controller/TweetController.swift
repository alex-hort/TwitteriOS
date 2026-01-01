//
//  TweetController.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 23/12/25.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "TweetHeader"

class TweetController : UICollectionViewController{
    
    //MARK: Properties
    
    private let tweet: Tweet
    private var actionSheetLauncher: ActionSheetLauncher!
    
    private var replies = [Tweet](){
        didSet {collectionView.reloadData()}
    }
    
    //MARK: Lifecycle
    
    init(tweet: Tweet){
        self.tweet = tweet
       
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollctionView()
        fetchReplies()
       
    }
    
    //MARK: API
    func fetchReplies(){
        TweetService.shared.fetchReplies(forTweet: tweet) { replies in
            self.replies = replies
        }
    }
    
    
    //MARK: Helpers
    func configureCollctionView(){
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier:  reuseIdentifier)
        collectionView.register(TweetHeader.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,  withReuseIdentifier: headerIdentifier )
    }
    
    fileprivate func showActionSheet(forUser user: User) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }
    
    
    
}

// MARK: UIcollection DS
extension TweetController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = replies[indexPath.row]
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TweetController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier
                      
                                                                     , for: indexPath) as! TweetHeader
        header.tweet = tweet
    
        header.delegate = self
        return header
    }
}

// MARK: UIcollectionViewDelegateFL
extension TweetController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweet)
        let captionSize = viewModel.size(forWidth: view.frame.width).height

        return CGSize(
            width: view.frame.width,
            height: captionSize + 220
        )

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}




extension TweetController: TweetHeaderDelegate{
  
    
    func showActionSheet() {
        if tweet.user.isCurrentUser{
            showActionSheet(forUser: tweet.user)
            
        } else {
            UserService.shared.checkIfUserIsFollowed(uid: tweet.user.uid) { isFollowed in
                var user = self.tweet.user
                user.isFollowed = isFollowed
                self.showActionSheet(forUser: user)
               
            }
        }
    }
}


//MARK: ActionSheetLauncherDelegate
extension TweetController: ActionSheetLauncherDelegate{
    func didSelect(option: ActionSheetOptions) {
        print("Debug: Option is controller \(option.description)")
    }
    
    
}
