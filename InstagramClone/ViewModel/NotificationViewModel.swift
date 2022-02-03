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
        
        attText.append(NSAttributedString(string: " \(timestampString ?? "")",  attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attText
    }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .brief
        return formatter.string(from: notification.timeStamp.dateValue(), to: Date())
    }
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
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
