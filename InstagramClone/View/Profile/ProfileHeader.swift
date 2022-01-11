//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 11.01.2022.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    static let reuseIdentifier = "profileHeader"
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Username"
        lb.font = .boldSystemFont(ofSize: 14)
        return lb
    }()
    
    private let editProfileFollowButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Edit Profile", for: .normal)
        bt.titleLabel?.font = .boldSystemFont(ofSize: 14)
        bt.setTitleColor(.black, for: .normal)
        bt.layer.cornerRadius = 3
        bt.layer.borderWidth = 0.5
        bt.layer.borderColor = UIColor.lightGray.cgColor
        bt.addTarget(self, action: #selector(handleeditProfileFollowTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var postLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributedText(value: 1, label: "posts")
        return lb
    }()
    
    private lazy var followersLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributedText(value: 1, label: "followers")
        return lb
    }()
    
    private lazy var followingLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributedText(value: 1, label: "following")
        return lb
    }()
    
    let gridButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "grid"), for: .normal)
        return bt
    }()
    
    let listButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "list"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()

    let bookmarkButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "ribbon"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func attributedText(value: Int, label: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    
    //MARK: - Actions
    
    @objc private func handleeditProfileFollowTapped() {
        print("DEBUG: tapped handleeditProfileFollowTapped")

    }
}
