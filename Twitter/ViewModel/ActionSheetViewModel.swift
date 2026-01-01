//
//  ActionSheetViewModel.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 27/12/25.
//

import Foundation

struct ActionSheetViewModel{
    
    private let user: User
    
    var options: [ActionSheetOptions]{
        var result = [ActionSheetOptions]()
        
        if user.isCurrentUser{
            result.append(.delete)
        } else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            result.append(followOption)
        }
        result.append(.report)
        return result
    }
    
    init(user: User) {
        self.user = user
    }
    
    
}

enum ActionSheetOptions{
    case follow(User)
    case unfollow(User)
    case report
    case delete
    
    var description: String{
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            "Report Tweet"
        case .delete:
            "Delete Tweet"
        }
        return ""
    }
}
