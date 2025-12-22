//
//  User.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 17/12/25.
//
import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let username: String
    var profileImageUrl: URL?
    let fullname: String
    let email: String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var isCurrentUser:Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            let cleanUrlString = profileImageUrlString.replacingOccurrences(of: ":443", with: "")
            
            if let url = URL(string: cleanUrlString), url.scheme != nil {
                self.profileImageUrl = url
            } else {
                self.profileImageUrl = nil
            }
        } else {
            self.profileImageUrl = nil
        }
    }
}


struct UserRelationStats{
    var followers: Int
    var following: Int
}
