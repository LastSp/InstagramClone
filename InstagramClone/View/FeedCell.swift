//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 22.12.2021.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLikePost post: Post)
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String)
}


class FeedCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseIdentifier = "feedCell"
    
    weak var delegate: FeedCellDelegate?
    
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private let usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - LifeCycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 20
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top:captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func didTapComments() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowCommentsFor: viewModel.post)
    }
    
    @objc func didTapLike() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLikePost: viewModel.post)
    }
    
    @objc func showUserProfile() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowProfileFor: viewModel.post.ownerUid)
    }

    
    //MARK: - Helpers

    private func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl, completed: nil)
        usernameButton.setTitle(viewModel.username, for: .normal)
        
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        likesLabel.text = viewModel.likesLabelText
        likeButton.tintColor = viewModel.likesButtonTintColor
        likeButton.setImage(viewModel.likesButtonImage, for: .normal)
    }
    

    
}
