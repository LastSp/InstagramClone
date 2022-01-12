//
//  ProfileViewHeader.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 11.01.2022.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var username: String {
        return user.username
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followingButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow" 
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        attributedText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        attributedText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        attributedText(value: user.stats.posts, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    private func attributedText(value: Int, label: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
}
