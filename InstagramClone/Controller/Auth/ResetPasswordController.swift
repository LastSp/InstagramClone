//
//  ResetPasswordController.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 02.02.2022.
//

import UIKit

protocol ResetPasswordControllerDelegate: AnyObject {
    func controllerDidSentResetPasswordLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: UIViewController {
    //MARK: - Properties
    
    private var viewModel = ResetPasswordViewModel()
    var email: String?
    
    weak var delegate: ResetPasswordControllerDelegate?
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let iconImage = UIImageView(image: UIImage(named: "Instagram_logo_white"))
    
    let resetPasswordButton: UIButton = {
        let button = CustomAuthenticationButton(name: "Reset password")
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.4)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    //MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        emailTextField.text = email
        viewModel.email = email
        updateForm()
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        view.addSubview(stackView)
        
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    //MARK: - Actions
    
    @objc func handleResetPassword() {
        guard let email = emailTextField.text else { return }
        showLoader(true)
        AuthService.resetPassword(forEmail: email) { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
                print("DEBUG: Failed to reset password with error: \(error.localizedDescription)")
                return
            }
            
            self.delegate?.controllerDidSentResetPasswordLink(self)
        }
    }
    
    @objc func handleDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
            viewModel.email = sender.text
        
        updateForm()
    }
    
}

//MARK: - FormViewModel

extension ResetPasswordController: FormViewModel {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetPasswordButton.isEnabled = viewModel.formIsVaild
    }
}
