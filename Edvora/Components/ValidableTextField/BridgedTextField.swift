//
//  BridgedTextField.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 04/12/21.
//

import SwiftUI


// MARK: - BridgedTextField

struct BridgedTextField: View {
    
    @Binding var text: String
    
    @Binding var responding: Bool
    
    let onUpdate: (UITextField) -> Void
    
    let onSubmit: () -> Void
    
    var body: some View {
        BridgeView(text: $text, responding: $responding, onUpdate: onUpdate, onSubmit: onSubmit)
    }
}

// MARK: - BridgeView

extension BridgedTextField {
    
    struct BridgeView: UIViewRepresentable {
        
        @Binding var text: String
        
        @Binding var responding: Bool
        
        let onUpdate: (UITextField) -> Void
        
        let onSubmit: () -> Void
        
        func makeUIView(context: Context) -> UITextField {
            context.coordinator.textField
        }
        
        func updateUIView(_ view: UITextField, context: Context) {
            context.coordinator.update(text: text, responding: responding, onUpdate: onUpdate)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
    }
}

// MARK: - Coordinator

extension BridgedTextField.BridgeView {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        let textField: UITextField =  {
            let textField = UITextField()
            return textField
        }()
        
        let parent: BridgedTextField.BridgeView
        
        init(parent: BridgedTextField.BridgeView) {
            self.parent = parent
        }
        
        
        func update(
            text: String,
            responding: Bool,
            onUpdate handler: (UITextField) -> Void
        ) {
            handler(textField)
            textField.delegate = self
            textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
            textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            textField.text = text
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.parent.onSubmit()
            return true
        }
    }
}
