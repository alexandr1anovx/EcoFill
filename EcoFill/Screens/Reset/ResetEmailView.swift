//
//  ChangeEmailScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.03.2024.
//

import SwiftUI
import Firebase

struct ResetEmailView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
    // MARK: - Private Properties
    @FocusState private var textField: TextFieldContent?
    @State private var email: String = ""
    @State private var currentPassword: String = ""
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                CustomTextField(
                    inputData: $email,
                    title: "New email",
                    placeholder: "emailname@example.com",
                    isSecureField: false
                )
                .focused($textField, equals: .email)
                .onSubmit { textField = .password }
                .submitLabel(.next)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                
                CustomTextField(
                    inputData: $currentPassword,
                    title: "Current password",
                    placeholder: "Repeat your current password",
                    isSecureField: true
                )
                .focused($textField, equals: .password)
                .onSubmit { textField = .confirmPassword }
                .submitLabel(.next)
                
                ResetBtn(img: .checkmark, data: "") {
                    Task {
                        await authenticationVM.updateEmail(
                            to: email,
                            withPassword: currentPassword
                        )
                    }
                    return textField = nil
                }
                .opacity(isValidForm ? 1.0 : 0.0)
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 30)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissXBtn()
                        .foregroundStyle(.red)
                }
            }
            .onAppear { textField = .initials } // Place cursor on first field
            .alert(item: $authenticationVM.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
        }
    }
}

// MARK: - AuthenticationForm
extension ResetEmailView: AuthenticationForm {
    var isValidForm: Bool {
        return email.isValidEmail && currentPassword.count > 5
    }
}
