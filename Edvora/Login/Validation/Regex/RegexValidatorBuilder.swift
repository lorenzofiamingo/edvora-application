//
//  RegexValidatorBuilder.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


@resultBuilder
struct RegexValidatorBuilder {
    
    static func buildBlock(_ components: RegexRule...) -> [RegexRule] {
        components
    }
    
    static func buildArray(_ components: [[RegexRule]]) -> [RegexRule] {
        components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [RegexRule]?) -> [RegexRule] {
        component ?? []
    }
    
    static func buildEither(first component: [RegexRule]) -> [RegexRule] {
        component
    }
    
    static func buildEither(second component: [RegexRule]) -> [RegexRule] {
        component
    }
}
