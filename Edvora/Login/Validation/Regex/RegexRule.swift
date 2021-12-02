//
//  RegexRule.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation

protocol RegexRule {
    
    var regex: String { get }
    
    var reason: String { get }
}
