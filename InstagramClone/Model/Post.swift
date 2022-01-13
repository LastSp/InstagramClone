//
//  Post.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//

import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timeStamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerUsername: String
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
