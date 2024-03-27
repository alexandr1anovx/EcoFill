//
//  ChangePasswordScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.03.2024.
//

import SwiftUI

struct ResetPasswordView: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  @State private var currentPassword: String = ""
  @State private var newPassword: String = ""
  @State private var confirmPassword: String = ""
  
  @FocusState private var fieldContent: TextFieldContent?
  
  var body: some View {
    
    NavigationStack {
     
      VStack(alignment: .leading, spacing: 10) {
        CustomTextField(inputData: $currentPassword,
                        title: "Current password",
                        placeholder: "Must match the current password.",
                        isSecureField: true)
        .focused($fieldContent, equals: .password)
        .onSubmit { fieldContent = .newPassword }
        .submitLabel(.next)
        
        CustomTextField(inputData: $newPassword,
                        title: "New password",
                        placeholder: "Must contain at least 6 characters.")
        .focused($fieldContent, equals: .newPassword)
        .onSubmit { fieldContent = .confirmPassword }
        .submitLabel(.next)
        
        CustomTextField(inputData: $confirmPassword,
                        title: "Confirm new password",
                        placeholder: "Must match the password above.",
                        isSecureField: true)
        .focused($fieldContent, equals: .confirmPassword)
        .onSubmit { fieldContent = nil }
        .submitLabel(.done)
        
        // MARK: - Confirmation
        
        UniversalButton(image: .checkmark, title: "Reset", color: .white) {
          Task {
//            await authenticationVM.updateEmail(newEmail: email, currentPassword: currentPassword)
          }
          return fieldContent = nil
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .opacity(isValidForm ? 1.0 : 0.0)
        
        Spacer()
      }
      .padding(.horizontal, 15)
      .padding(.top, 30)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) { DismissXButton() }
      }
      // Enable the keyboard.
      .onAppear { fieldContent = .fullName }
    }
  }
}


// MARK: - Extensions

extension ResetPasswordView: AuthenticationForm {
  var isValidForm: Bool {
    return currentPassword.count > 5
    && newPassword.count > 5
    && confirmPassword == newPassword
  }
}

#Preview {
  ResetPasswordView()
    .environmentObject(AuthenticationViewModel())
}

