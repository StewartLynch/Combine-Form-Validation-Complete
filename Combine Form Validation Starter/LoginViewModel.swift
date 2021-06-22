//
//  LoginViewModel.swift
//  Combine Form Validation Starter
//
//  Created by Stewart Lynch on 2021-06-20.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPw = ""
    @Published var birthYear = Constants.currentYear
    @Published var showYearSelector = false
    
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var isPasswordConfirmValid = false
    @Published var isAgeValid = false
    @Published var canSubmit = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
    
    init() {
        $email
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isEmailCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isPasswordCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $birthYear
            .map { birthYear in
                return (Constants.currentYear - birthYear) >= 21
            }
            .assign(to: \.isAgeValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $confirmPw)
            .map { password, confirmPw in
                return password == confirmPw
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest4($isEmailCriteriaValid, $isPasswordCriteriaValid, $isPasswordConfirmValid, $isAgeValid)
            .map { isEmailCriteriaValid, isPasswordCriteriaValid, isPasswordConfirmValid, isAgeValid in
                return (isEmailCriteriaValid && isPasswordCriteriaValid && isPasswordConfirmValid && isAgeValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    var confirmPwPrompt: String {
        isPasswordConfirmValid ?
            ""
            :
            "Password fields to not match"
    }
    
    var emailPrompt: String {
        isEmailCriteriaValid ?
            ""
            :
            "Enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
            ""
            :
            "Must be at least 8 characters containing at least one number and one letter and one special character."
    }
    
    var agePrompt: String {
        isAgeValid ?
            "Year of birth"
            :
            "Year of birth (must be 21 years old)"
    }
    
    func login() {
        print("Logging in \(email).")
        email = ""
        password = ""
        confirmPw = ""
        birthYear = Constants.currentYear   
    }
}
