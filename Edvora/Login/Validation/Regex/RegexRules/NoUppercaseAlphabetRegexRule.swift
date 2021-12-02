//
//  NoUppercaseAlphabetRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct NoUppercaseAlphabetRegexRule: RegexRule {
    
    var regex: String {
        #"^[^A-Z]*$"#
    }
    
    var reason: String {
        "%@ should not contain uppercase alphabet."
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == NoUppercaseAlphabetRegexRule {
    
    static var noUppercaseAlphabet: NoUppercaseAlphabetRegexRule {
        NoUppercaseAlphabetRegexRule()
    }
}
