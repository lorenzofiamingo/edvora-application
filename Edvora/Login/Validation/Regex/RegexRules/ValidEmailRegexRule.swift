//
//  ValidEmailRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct ValidEmailRegexRule: RegexRule {
    
    var regex: String {
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
    }
    
    var reason: String {
        "%@ should be a valid email."
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == ValidEmailRegexRule {
    
    static var validEmail: ValidEmailRegexRule {
        ValidEmailRegexRule()
    }
}
