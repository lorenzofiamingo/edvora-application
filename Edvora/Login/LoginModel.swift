//
//  LoginModel.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 02/12/21.
//

import SwiftUI
import Combine

class LoginModel: ObservableObject {
    
    @Published var username = ""
    
    @Published var password = ""
    
    @Published var email = ""
    
    @Published var usernameValidation: ValidationState = .valid
    
    @Published var passwordValidation: ValidationState = .valid
    
    @Published var emailValidation: ValidationState = .valid
    
    @Published var lazyUsernameValidation: ValidationState = .valid
    
    @Published var lazyPasswordValidation: ValidationState = .valid
    
    @Published var lazyEmailValidation: ValidationState = .valid
    
    private let usernameValidator: Validator = PlainRegexValidator {
        NotEmptyRegexRule()
        NoSpacesRegexRule()
        NoUppercaseAlphabetRegexRule()
    }
    
    private let passwordValidator: Validator = PlainRegexValidator {
        NotEmptyRegexRule()
        MinimumCharactersRegexRule(amount: 8)
        MinimumNumbersRegexRule(amount: 1)
        MinimumUppercaseAlphabetRegexRule(amount: 1)
        MinimumLowercaseAlphabetRegexRule(amount: 1)
    }
    
    private let emailValidator: Validator = PlainRegexValidator(rules: .validEmail)
    
    private let removeLazinessSubject = PassthroughSubject<Void, Never>()
    
    init() {
        $username
            .map(usernameValidator.validate)
            .assign(to: &$usernameValidation)
        $password
            .map(passwordValidator.validate)
            .assign(to: &$passwordValidation)
        $email
            .map(emailValidator.validate)
            .assign(to: &$emailValidation)
        
        $usernameValidation
            .prepend($usernameValidation
                        .dropFirst()
                        .debounce(for: 2.0, scheduler: DispatchQueue.main)
                        .filter { $0 != .valid }
                        .merge(with: removeLazinessSubject.map { self.usernameValidation })
                        .first()
            )
            .assign(to: &$lazyUsernameValidation)
        
        
        $passwordValidation
            .prepend($passwordValidation
                        .dropFirst()
                        .debounce(for: 2.0, scheduler: DispatchQueue.main)
                        .filter { $0 != .valid }
                        .merge(with: removeLazinessSubject.map { self.passwordValidation })
                        .first()
            )
            .assign(to: &$lazyPasswordValidation)
        
        $emailValidation
            .prepend($emailValidation
                        .dropFirst()
                        .debounce(for: 2.0, scheduler: DispatchQueue.main)
                        .filter { $0 != .valid }
                        .merge(with: removeLazinessSubject.map { self.emailValidation })
                        .first()
            )
            .assign(to: &$lazyEmailValidation)
        
    }
    
    func removeValidationLaziness() {
        removeLazinessSubject.send()
    }
    
    func login() {
        
    }
}
