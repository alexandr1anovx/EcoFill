//
//  ChangeEmailScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.03.2024.
//

import SwiftUI

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ResetEmailView: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  @State private var email: String = ""
  @State private var currentPassword: String = ""
  
  @FocusState private var focusedTextField: TextFieldInputData?
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - Text Fields
        
        CustomTextField(inputData: $email,
                        title: "New email address",
                        placeholder: "example@gmail.com")
        .focused($focusedTextField, equals: .email)
        .onSubmit { focusedTextField = .password }
        .submitLabel(.next)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        
        CustomTextField(inputData: $currentPassword,
                        title: "Current password",
                        placeholder: "Repeat your current password.",
                        isSecureField: true)
        .focused($focusedTextField, equals: .password)
        .onSubmit { focusedTextField = .confirmPassword }
        .submitLabel(.next)
        
        UniversalButton(image: .checkmark, title: "Confirm", color: .white, spacing: 10) {
          Task {
            await authenticationVM.updateEmail(newEmail: email, currentPassword: currentPassword)
          }
          return focusedTextField = nil
        }
        .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
        .opacity(isValidForm ? 1.0 : 0.0)
        
        Spacer()
      }
      .padding(.horizontal, 15)
      .padding(.top, 30)
      
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          DismissXButton()
        }
      }
      .onAppear {
        // Enable the keyboard.
        focusedTextField = .fullName
      }
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
    }
  }
}

// MARK: - Extensions

extension ResetEmailView: AuthenticationForm {
  var isValidForm: Bool {
    return email.isValidEmail && currentPassword.count > 5
  }
}

#Preview {
  ResetEmailView()
    .environmentObject(AuthenticationViewModel())
}

