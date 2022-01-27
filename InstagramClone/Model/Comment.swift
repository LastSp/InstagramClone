//
//  Comment.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 13.01.2022.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let commentText: String
    let profileImageUrl: String
    let timeStamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
}
