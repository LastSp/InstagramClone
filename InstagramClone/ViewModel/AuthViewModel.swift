//
//  AuthViewModel.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 22.12.2021.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModelProtocol {
    var formIsVaild: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModelProtocol {
    
    var email: String?
    var password: String?
    
    var formIsVaild: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
        && email?.isVaildEmail == true
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsVaild ?  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(1) :  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.4)
    }
    
    var buttonTitleColor: UIColor {
        return formIsVaild ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    var username: String?
    var fullname: String?
    
    var formIsVaild: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
        && email?.isVaildEmail == true
        && fullname?.isEmpty == false
        && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsVaild ?  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(1) :  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.4)
    }
    
    var buttonTitleColor: UIColor {
        return formIsVaild ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
