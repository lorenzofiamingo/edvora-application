//
//  TextField+secure.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 09/12/21.
//

import SwiftUI
import Runtime

extension TextField {
    
    func secure(_ secure: Bool = true) -> TextField {
        if secure {
            var secureField = self
            withUnsafeMutablePointer(to: &secureField) { pointer in
                
                
                let fieldDescriptor = pointer.pointee
                
                
                let offset = 0
                let valuePointer = UnsafeMutableRawPointer(mutating: pointer)
                let valuePointer = UnsafeMutableRawPointer(valuePointer.pointee.isSecure)
                // valuePointer.pointee = secure
            }
            
            let info = try! typeInfo(of: Self.self)
            print(info.mangledName)
            let property = try! info.property(named: "isSecure")
            try! property.set(value: true, on: &secureField)
            let t = secureField
            return t
        } else {
            return self
        }
    }
}

struct 
