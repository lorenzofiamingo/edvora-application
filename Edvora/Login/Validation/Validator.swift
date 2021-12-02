//
//  Validator.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import Foundation


protocol Validator {
    
    func validate(_ text: String) -> ValidationState
}
