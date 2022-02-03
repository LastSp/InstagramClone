//
//  LoginController.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 22.12.2021.
//

import UIKit

protocol AuthenticationDelegate: AnyObject  {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    //MARK: - Properties
    private var viewModel = LoginViewModel()
    
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = CustomAuthenticationButton(name: "Sign In")
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.4)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.addTarget(self, action: #selector(handlelogIn), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help signing in")
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private let doNotHaveAccoutButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Actions
    
    @objc func handlelogIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc func handleForgotPassword() {
        let controller = ResetPasswordController()
        controller.email = emailTextField.text
        controller.delegate  = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helpers

    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        view.addSubview(stackView)
        
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(doNotHaveAccoutButton)
        
        doNotHaveAccoutButton.centerX(inView: view)
        doNotHaveAccoutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
   
}

//MARK: - FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsVaild
    }
}

//MARK: - ResetPasswordControllerDelegate

extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSentResetPasswordLink(_ controller: ResetPasswordController) {
        navigationController?.popViewController(animated: true)
        self.showMessage(withTitle: "Success", message: "We sent a link to your email so you could reset the password")
    }
    
    
}
