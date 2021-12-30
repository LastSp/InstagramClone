//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 30.12.2021.
//

import FirebaseStorage
import Foundation

struct ImageUpoader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrlString = url?.absoluteString else { return }
                completion(imageUrlString)
            }
        }
    }
}
