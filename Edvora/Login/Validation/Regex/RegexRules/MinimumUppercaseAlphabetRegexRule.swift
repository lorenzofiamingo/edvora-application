//
//  MinimumUppercaseAlphabetRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct MinimumUppercaseAlphabetRegexRule: RegexRule {
    
    let amount: Int
    
    var regex: String {
        #"[A-Z]{\#(amount),}"#
    }
    
    var reason: String {
        if amount == 1 {
            return "%@ should contain \(amount) uppercase letter at least."
        } else {
            return "%@ should contain \(amount) uppercase letters at least."
        }
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == MinimumUppercaseAlphabetRegexRule {
    
    static func minimumUppercaseAlphabet(_ amount: Int) -> MinimumUppercaseAlphabetRegexRule {
        MinimumUppercaseAlphabetRegexRule(amount: amount)
    }
}
