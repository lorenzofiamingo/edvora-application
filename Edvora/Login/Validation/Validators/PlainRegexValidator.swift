//
//  PlainRegexValidator.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


struct PlainRegexValidator: RegexValidator {
    
    internal let rules: [RegexRule]
    
    init(rules: RegexRule...) {
        self.rules = rules
    }
    
    init(@RegexValidatorBuilder _ rules: () -> [RegexRule]) {
        self.rules = rules()
    }
}
