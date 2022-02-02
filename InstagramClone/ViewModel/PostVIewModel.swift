//
//  PostVIewModel.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//

import UIKit

struct PostViewModel {
    var post: Post
    
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
    
    var likesButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likesButtonImage: UIImage? {
        return post.didLike ? UIImage(named: "like_selected") : UIImage(named: "like_unselected")
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(likes) likes"
        }
        return "\(likes) like"
    }
    
    var timestamp: String {
        return Date(timeIntervalSince1970: Double(post.timeStamp.seconds)).calendarTimeSinceNow()
    }
    
    init(post: Post){
        self.post = post
    }
    

}
