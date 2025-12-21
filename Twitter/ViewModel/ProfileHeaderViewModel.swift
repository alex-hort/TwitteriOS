//
//  ProfileHeaderViewModel.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 21/12/25.
//


import UIKit


enum ProfileFilterOptions: Int, CaseIterable{
    case tweets
    case replies
    case likes

    
    var description: String{
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets & Replies"
        case .likes:
            return "Likes"
  
        }
    }
}


struct ProfileHeaderViewModel{
    
    private let user: User
    let usernameText: String
    
    var followerString: NSAttributedString? {
        return attributedText(witValue: 1000, text: "Followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(witValue: 92, text: "Following")
    }
    var actionButtonTitle: String{
        if user.isCurrentUser{
            return "Edit Profile"
        } else {
            return "Follow"
        }
        
    }
    
    init(user: User){
        self.user = user
        self.usernameText = "@" + user.username
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

}
