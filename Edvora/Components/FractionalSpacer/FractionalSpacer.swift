//
//  FractionalSpacer.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 17/12/21.
//

import SwiftUI

struct FractionalSpacer: View {
    
    var fraction: Int
    
    var minLength: CGFloat?
    
    init(_ fraction: Int, minLenght: CGFloat? = 0) {
        self.fraction = fraction
        self.minLength = minLenght
    }
    
    var body: some View {
        ForEach(0..<fraction, id: \.self) { i in
            Spacer(minLength: i == 0 ? minLength : 0)
        }
    }
}
