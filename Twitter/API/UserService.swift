//
//  UserService.swift
//  Twitter
//
//  Created by Alexis Horteales Espinosa on 17/12/25.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(uid: String,completion: @escaping(User) -> Void) {
    
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            DispatchQueue.main.async {
                completion(user)
            }
        }
    }
}
