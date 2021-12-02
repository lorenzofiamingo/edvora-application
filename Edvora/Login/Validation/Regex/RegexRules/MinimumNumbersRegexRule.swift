//
//  MinimumNumbersRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct MinimumNumbersRegexRule: RegexRule {
    
    let amount: Int
    
    var regex: String {
        #"[0-9]{\#(amount),}"#
    }
    
    var reason: String {
        if amount == 1 {
            return "%@ should contain \(amount) number at least."
        } else {
            return "%@ should contain \(amount) numbers at least."
        }
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == MinimumNumbersRegexRule {
    
    static func minimumNumbers(_ amount: Int) -> MinimumNumbersRegexRule {
        MinimumNumbersRegexRule(amount: amount)
    }
}
