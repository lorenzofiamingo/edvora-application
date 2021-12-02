//
//  AlwaysNotValidValidator.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct AlwaysNotValidValidator: Validator {
    
    func validate(_ text: String) -> ValidationState {
        .notValid(reasons: ["Always Not Valid"])
    }
}

// MARK: - Static Member Lookup

extension Validator where Self == AlwaysNotValidValidator {
    
    static var alwaysNotValid: AlwaysNotValidValidator {
        AlwaysNotValidValidator()
    }
}
