//
//  PostService.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//


import Firebase
import UIKit

struct PostService {
    static func uploadPosts(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUpoader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String: Any]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping (([Post]) -> Void)) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
}
