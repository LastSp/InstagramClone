//
//  User.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 11.01.2022.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let uid: String
    let username: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
    }
}
