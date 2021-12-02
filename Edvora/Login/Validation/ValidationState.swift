//
//  ValidationState.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


enum ValidationState {
    
    case valid
    case notValid(reasons: [String])
}

// MARK: - Equatable Conformance

extension ValidationState: Equatable {}


// MARK: - ExpressibleByBooleanLiteral Conformance

extension ValidationState: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        if value {
            self = .valid
        } else {
            self = .notValid(reasons: [])
        }
    }
}
