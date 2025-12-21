//
//  TweetViewModel.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 20/12/25.
//

import Foundation
import UIKit


struct TweetViewModel{
    
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL?{
        return tweet.user.profileImageUrl
    }
    
    var userInfoText: NSAttributedString{
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont(name: "HelveticaNeue-Medium", size: 14) ?? ""])
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont(name: "AvenirNext-Regular", size: 14) ?? "", .foregroundColor: UIColor.lightGray
                                        ]))
        
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
