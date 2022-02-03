//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 12.01.2022.
//

import UIKit

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    //MARK: - Properties
    
    weak var delegate: UploadPostControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage?  {
        didSet {
            photoimageView.image = selectedImage
        }
    }
    
    private let photoimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter Caption..."
        tv.delegate = self
        tv.placeholderShouldCenter = false
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.text = "0/150"
        return lb
    }()
    

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(handleShare))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black

        view.addSubview(photoimageView)
        photoimageView.setDimensions(height: 180, width: 180)
        photoimageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        photoimageView.centerX(inView: view)
        photoimageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoimageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 100)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor, paddingRight: 12)
        
    }
    
    func checkMaxLenght(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    
    //MARK: - Actions
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func handleShare() {
        showLoader(true)
        guard let image = selectedImage,
              let caption = captionTextView.text else { return }
        
        guard let user = currentUser else { return }

        PostService.uploadPost(caption: caption, image: image, user: user) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post with error: \(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
}


//MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLenght(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
