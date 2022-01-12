//
//  InputTextView.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//

import Foundation
import UIKit

class InputTextView: UITextView {
    
    //MARK: - Properties
    
    var placeholderText: String? {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 7)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextEditChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleTextEditChanged() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
