//
//  PostVIewModel.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//

import UIKit

struct PostViewModel {
    let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(likes) likes"
        }
        return "\(likes) like"
    }
    
    init(post: Post){
        self.post = post
    }
}
