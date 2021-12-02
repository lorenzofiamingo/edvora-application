//
//  MinimumLowercaseAlphabetRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct MinimumLowercaseAlphabetRegexRule: RegexRule {
    
    let amount: Int
    
    var regex: String {
        #"[a-z]{\#(amount),}"#
    }
    
    var reason: String {
        if amount == 1 {
            return "%@ should contain \(amount) lowercase letter at least."
        } else {
            return "%@ should contain \(amount) lowercase letters at least."
        }
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == MinimumLowercaseAlphabetRegexRule {
    
    static func minimumLowercaseAlphabet(_ amount: Int) -> MinimumLowercaseAlphabetRegexRule {
        MinimumLowercaseAlphabetRegexRule(amount: amount)
    }
}
