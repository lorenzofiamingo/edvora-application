//
//  MinimumCharactersRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct MinimumCharactersRegexRule: RegexRule {
    
    let amount: Int
    
    var regex: String {
        #".{\#(amount),}"#
    }
    
    var reason: String {
        if amount == 1 {
            return "%@ should contain \(amount) character at least."
        } else {
            return "%@ should contain \(amount) characters at least."
        }
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == MinimumCharactersRegexRule {
    
    static func minimumCharacters(_ amount: Int) -> MinimumCharactersRegexRule {
        MinimumCharactersRegexRule(amount: amount)
    }
}
