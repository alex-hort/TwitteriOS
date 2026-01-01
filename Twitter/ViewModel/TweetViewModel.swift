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
    
    var usernameText: String{
        return "@\(user.username)"
    }
    
    var headerTimestamp: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ∙ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString?{
        return attributedText(witValue: tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString?{
        return attributedText(witValue: tweet.likes, text: "Likes")
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
    
    fileprivate func attributedText(witValue value: Int, text: String) -> NSAttributedString {
        
        let attributedTitle = NSMutableAttributedString(
            string: "\(value)",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12)
            ]
        )
        
        attributedTitle.append(
            NSAttributedString(
                string: " \(text)",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.gray
                ]
            )
        )
        
        return attributedTitle
    }
    
    func size(forWidth width: CGFloat) -> CGSize{
        let measurementLabel = UILabel()
        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
