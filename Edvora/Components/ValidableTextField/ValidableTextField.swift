//
//  ValidableTextField.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 04/12/21.
//

import SwiftUI

struct ValidableTextField<Leading: View, Trailing: View>: View {
    
    @FocusState private var focus
    
    private let title: String
    @Binding private  var text: String
    private let validation: ValidationState
    private let bridgeHandler: (UITextField) -> Void
    private let onSubmit: () -> Void
    private let leadingView: () -> Leading
    private let trailingView: () -> Trailing
    
    private let cornerRadius: CGFloat = 10
    private let fillColor: Color = Color(white: 0.98)
    private var borderColor: Color {
        if validation == .valid {
            return focus ? .accentColor : Color(white: 0.94)
        } else {
            return .red
        }
    }
    private let labelColor: Color = Color(white: 0.70)
    private let textPaddingHorizontal: CGFloat = 8
    private let end = CGPoint(x: 10, y: 0)
    private var notValidReason: String {
        if case .notValid(reasons: let reasons) = validation, let reason = reasons.first {
            return String(format: reason, title)
        } else {
            return " "
        }
    }
    
    var line: CTLine {
        let font = UIFont.preferredFont(forTextStyle: .caption1) as CTFont
        let attributedString = CFAttributedStringCreate(nil, title as CFString, [NSAttributedString.Key.font.rawValue: font] as CFDictionary)!
        return CTLineCreateWithAttributedString(attributedString)
    }
    
    init(_ title: String,
         text: Binding<String>,
         validation: ValidationState = .valid,
         bridgeHandler: @escaping (UITextField) -> Void = { _ in },
         onSubmit: @escaping () -> Void = { },
         @ViewBuilder leadingView: @escaping () -> Leading,
         @ViewBuilder trailingView: @escaping () -> Trailing) {
        self.title = title
        self._text = text
        self.validation = validation
        self.bridgeHandler = bridgeHandler
        self.onSubmit = onSubmit
        self.leadingView = leadingView
        self.trailingView = trailingView
    }
    
    @State private var responding: Bool = true
    var body: some View {
        VStack {
        HStack {
            leadingView()
            BridgedTextField(text: $text, responding: .constant(focus), onUpdate: bridgeHandler, onSubmit: onSubmit)
            .focused($focus)
            trailingView()
        }
        .padding()
        .frame(height: 52)
        .background(background)
        .onTapGesture {
            focus = true
        }
            Text(notValidReason)
                .font(.caption2)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .id(notValidReason)
                .transition(.opacity)
        }
    }
    
    var background: some View {
        ZStack {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(fillColor)
                outlinePath(in: proxy.frame(in: .local))
                    .stroke(borderColor, lineWidth: 1)
                labelPath
                    .fill(labelColor)
            }
        }
    }
    
    func outlinePath(in rect: CGRect) -> Path {
        Path { path in
            let topRight = CGPoint(x: rect.size.width, y: 0)
            let bottomRight = CGPoint(x: rect.size.width, y: rect.size.height)
            let bottomLeft = CGPoint(x: 0, y: rect.size.height)
            let topLeft = CGPoint(x: 0, y: 0)
            let lastRun = line.glyphRuns().last!
            let lastPositionX = lastRun.glyphPositions().last!.x
            let lastAdvanceWidth = lastRun.glyphsAdvances().last!.width
            let startX = lastPositionX + lastAdvanceWidth + end.x + 2 * textPaddingHorizontal
            path.move(to: CGPoint(x: startX , y: 0))
            path.addArc(tangent1End: topRight, tangent2End: bottomRight, radius: cornerRadius)
            path.addArc(tangent1End: bottomRight, tangent2End: bottomLeft, radius: cornerRadius)
            path.addArc(tangent1End: bottomLeft, tangent2End: topLeft, radius: cornerRadius)
            path.addArc(tangent1End: topLeft, tangent2End: topRight, radius: cornerRadius)
            path.addLine(to: end)
        }
    }
    
    var labelPath: Path {
        Path { path in
            for glyphRun in line.glyphRuns() {
                let font = glyphRun.font
                let glyphs = glyphRun.glyphs()
                let glyphsPositions = glyphRun.glyphPositions()
                let height = font.xHeight()
                for (idx, glyph) in glyphs.enumerated() {
                    let positionTransform = CGAffineTransform(translationX: glyphsPositions[idx].x + end.x + textPaddingHorizontal, y: -glyphsPositions[idx].y + end.y + height/2)
                        .scaledBy(x: 1, y: -1)
                    
                    // path is nil for space
                    if let glyphCGPath = font.path(for: glyph, transform: positionTransform) {
                        path.addPath(Path(glyphCGPath))
                    }
                }
            }
        }
    }
}


extension ValidableTextField where Trailing == EmptyView  {
    
    init(
        _ title: String,
         text: Binding<String>,
        validation: ValidationState = .valid,
        bridgeHandler: @escaping (UITextField) -> Void = { _ in },
        onSubmit: @escaping () -> Void = { },
         @ViewBuilder leadingView: @escaping () -> Leading
    ) {
        self.init(title, text: text, validation: validation, bridgeHandler: bridgeHandler, onSubmit: onSubmit, leadingView: leadingView, trailingView: {
            EmptyView()
        })
    }
}

extension ValidableTextField where Leading == EmptyView  {
    
    // !!!: Potentially unstable Swift feature
    @_disfavoredOverload
    init(
        _ title: String,
         text: Binding<String>,
        validation: ValidationState = .valid,
        bridgeHandler: @escaping (UITextField) -> Void = { _ in },
        onSubmit: @escaping () -> Void = { },
         @ViewBuilder trailingView: @escaping () -> Trailing
    ) {
        self.init(title, text: text, validation: validation, bridgeHandler: bridgeHandler, onSubmit: onSubmit, leadingView: {
            EmptyView()
        }, trailingView: trailingView)
    }
}


extension ValidableTextField where Leading == EmptyView, Trailing == EmptyView   {
    
    init(
        _ title: String,
        text: Binding<String>,
        validation: ValidationState = .valid,
        bridgeHandler: @escaping (UITextField) -> Void = { _ in },
        onSubmit: @escaping () -> Void = { }
    ) {
        self.init(title, text: text, validation: validation, bridgeHandler: bridgeHandler, onSubmit: onSubmit, leadingView: {
            EmptyView()
        }, trailingView: {
            EmptyView()
        })
    }
}
