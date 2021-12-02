//
//  NotEmptyRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct NotEmptyRegexRule: RegexRule {
    
    var regex: String {
        #".+"#
    }
    
    var reason: String {
        "%@ should not be empty."
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == NotEmptyRegexRule {
    
    static var notEmpty: NotEmptyRegexRule {
        NotEmptyRegexRule()
    }
}
