//
//  AuthService.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 30.12.2021.
//

import UIKit
import Firebase
import AVFoundation

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let userName: String
    let profileImage: UIImage
}
struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUpoader.uploadImage(image: credentials.profileImage) { imageUrlString in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrlString,
                                           "uid": uid,
                                           "username": credentials.userName]
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                
            }
        }
    }
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
