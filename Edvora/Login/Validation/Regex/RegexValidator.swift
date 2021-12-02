//
//  RegexValidator.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation

protocol RegexValidator: Validator {
    
    var rules: [RegexRule] { get }
    
}


// MARK: - Validator Conformance

extension RegexValidator {
    
    func validate(_ text: String) -> ValidationState {
        var invalidityReasons: [String] = []
        for rule in rules {
            if text.range(of: rule.regex, options: .regularExpression) == nil {
                invalidityReasons.append(rule.reason)
            }
        }
        return invalidityReasons.isEmpty ? .valid : .notValid(reasons: invalidityReasons)
    }
}
