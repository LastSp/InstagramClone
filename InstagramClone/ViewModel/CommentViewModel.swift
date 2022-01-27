//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 26.01.2022.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var username: String {
        return comment.username
    }
    
    var commentTextString: String {
        return comment.commentText
    }

    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentLabelText() -> NSAttributedString {
        let attString = NSMutableAttributedString(string: "\(username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attString.append(NSAttributedString(string: commentTextString, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attString
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
