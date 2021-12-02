//
//  NoSpacesRegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct NoSpacesRegexRule: RegexRule {
    
    var regex: String {
        #"^\S*$"#
    }
    
    var reason: String {
        "%@ should not contain spaces."
    }
}

// MARK: - Static Member Lookup

extension RegexRule where Self == NoSpacesRegexRule {
    
    static var noSpaces: NoSpacesRegexRule {
        NoSpacesRegexRule()
    }
}
