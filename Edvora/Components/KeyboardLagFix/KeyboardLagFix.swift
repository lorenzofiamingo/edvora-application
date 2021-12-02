//
//  KeyboardLagFix.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 18/12/21.
//

import SwiftUI

private struct KeyboardLagFix: ViewModifier {
    
    @State private var maxBottomInset: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { (proxy: GeometryProxy) in
            content
                .onChange(of: proxy.safeAreaInsets.bottom) { bottomInset in
                    if (bottomInset > maxBottomInset) {
                        maxBottomInset = bottomInset
                    } else if (bottomInset < maxBottomInset/2) {
                        withAnimation(.easeOut) {
                            maxBottomInset = 0
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Spacer()
                        .frame(height: additionalInset(proxy: proxy))
                }
        }
    }
    
    func additionalInset(proxy: GeometryProxy) -> CGFloat {
        let additionalInset = maxBottomInset-proxy.safeAreaInsets.bottom
        guard additionalInset > 0 else { return 0 }
        return additionalInset
    }
}

extension View {
    
    func fixKeyboardLag() -> some View {
        modifier(KeyboardLagFix())
    }
}
