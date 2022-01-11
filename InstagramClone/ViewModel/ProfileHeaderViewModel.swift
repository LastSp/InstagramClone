//
//  ProfileViewHeader.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 11.01.2022.
//

import Foundation

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
    
    init(user: User) {
        self.user = user
    }
}
