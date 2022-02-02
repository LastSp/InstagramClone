//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 01.02.2022.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    
    var postImageUrl: URL? {
        return URL(string: notification.postImageUrl ?? "")
    }
    
    var profileImageUrl: URL? {
        return URL(string: notification.userProfileImageUrl)
    }
    
    var postId: String? {
        return notification.postId
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        attText.append(NSAttributedString(string: " \(message)", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        attText.append(NSAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attText
    }
    
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
    }
    
    var shouldHideFollowButton: Bool {
        return notification.type != .follow
    }
    
    var followButtonText: String {
        return notification.userIsFollowed ? "Following": "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return notification.userIsFollowed ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return notification.userIsFollowed ? .black : .white
    }
    
    init(notification: Notification) {
        self.notification = notification
    }
}
