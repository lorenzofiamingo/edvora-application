//
//  AlwaysValidValidator.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import SwiftUI


struct AlwaysValidValidator: Validator {
    
    func validate(_ text: String) -> ValidationState {
        .valid
    }
}

// MARK: - Static Member Lookup

extension Validator where Self == AlwaysValidValidator {
    
    static var alwaysValid: AlwaysValidValidator {
        AlwaysValidValidator()
    }
}
