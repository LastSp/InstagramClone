//
//  UserCell.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 11.01.2022.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    //MARK: - Properties
    static let reuseIdentifier = "userCell"
    
    var viewModel: UserCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 15)
        lb.text = "Username"
        return lb
    }()
    
    private let fullnameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.text = "Fullname"
        lb.textColor = .lightGray
        return lb
    }()

    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        fullnameLabel.text = viewModel.fullname
        usernameLabel.text = viewModel.username
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
}
