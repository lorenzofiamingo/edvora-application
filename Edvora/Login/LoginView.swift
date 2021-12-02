//
//  LoginView.swift
//  Edvora
//
//  Created by Lorenzo Fiamingo on 02/12/21.
//

import SwiftUI

struct LoginView: View {
    
    @FocusState private var focusedField: LoginField?
    
    @StateObject private var model = LoginModel()
    
    var body: some View {
        GeometryReader { (proxy: GeometryProxy) in
            VStack {
                
                FractionalSpacer(2)
                
                Image("Logo")
                    .frame(minHeight: 0)
                    .opacity(proxy.size.height > 400 ? 1 : 0)
                
                FractionalSpacer(4)
                
                
                Group {
                    usernameField
                    passwordField
                    emailField
                }.padding(.bottom, 4)
                
                Link("Forgotten password?", destination: URL(string: "https://www.lorenzofiamingo.com")!)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                FractionalSpacer(2)
                
                Button(action: login) {
                    Text("LOGIN")
                        .frame(maxWidth: .infinity)
                        .frame(height: 38)
                }
                .font(.title3.weight(.semibold))
                .buttonStyle(.borderedProminent)
                .tint(Color("DeepBrown"))
                
                FractionalSpacer(1)
                
                Text(try! AttributedString(markdown: "Don't have an account? **[Sign Up](http://www.lorenzofiamingo.com)**"))
                    .font(.subheadline.weight(.light))
                    .foregroundColor(.secondary)
                
                FractionalSpacer(1)
            }
            .frame(maxWidth: 600)
            .padding(.horizontal, 4)
            .padding(.horizontal)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .fixKeyboardLag()
    }
    
    private func login() {
        model.removeValidationLaziness()
        if model.usernameValidation != .valid {
            focusedField = .username
        } else if model.passwordValidation != .valid {
            focusedField = .password
        } else if model.emailValidation != .valid {
            focusedField = .email
        } else {
            focusedField = nil
            model.login()
        }
    }
    
    // MARK: Username TextField
    private var usernameField: some View {
        ValidableTextField("Username", text: $model.username, validation: model.lazyUsernameValidation) { textField in
            textField.autocorrectionType = .no
            textField.textContentType = .username
            textField.returnKeyType = .next
            textField.autocapitalizationType = .none
        } onSubmit: {
            focusedField = .password
        } leadingView: {
            Image("person")
                .foregroundColor(Color(white: 0.7))
        }
        .focused($focusedField, equals: .username)
    }
    
    // MARK: Password TextField
    @State private var securingPassword = true
    private var passwordField: some View {
        ValidableTextField("Password", text: $model.password, validation: model.lazyPasswordValidation) { textField in
            textField.isSecureTextEntry = securingPassword
            textField.autocorrectionType = .no
            textField.textContentType = .password
            textField.returnKeyType = .next
            textField.autocapitalizationType = .none
        } onSubmit: {
            focusedField = .email
        } leadingView: {
            Image("key")
                .foregroundColor(Color(white: 0.7))
        } trailingView: {
            Button {
                securingPassword.toggle()
                focusedField = .password
            } label: {
                Image("eye")
            }
        }
        .focused($focusedField, equals: .password)
    }
    
    // MARK: Email TextField
    private var emailField: some View {
        ValidableTextField("Email address", text: $model.email, validation: model.lazyEmailValidation) { textField in
            textField.autocorrectionType = .no
            textField.textContentType = .emailAddress
            textField.keyboardType = .emailAddress
            textField.returnKeyType = .done
            textField.autocapitalizationType = .none
        } onSubmit: {
            login()
        } leadingView: {
            Image("at")
                .foregroundColor(Color(white: 0.7))
        }
        .focused($focusedField, equals: .email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
