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
    
    var timestamp: String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    
    var userInfoText: NSAttributedString{
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont(name: "HelveticaNeue-Medium", size: 14) ?? ""])
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont(name: "AvenirNext-Regular", size: 14) ?? "", .foregroundColor: UIColor.lightGray
                                                    ]))
        
        title.append(NSAttributedString(string: " • \(timestamp)",
                                        attributes: [.font: UIFont(name: "HelveticaNeue-Light", size: 12) ?? "", .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
