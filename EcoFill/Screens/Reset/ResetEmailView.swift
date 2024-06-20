//
//  ChangeEmailScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.03.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ResetEmailView: View {
  
  // MARK: - properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @State private var email: String = ""
  @State private var currentPassword: String = ""
  @FocusState private var fieldContent: TextFieldContent?
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - text Fields
        
        CustomTextField(inputData: $email,
                        title: "New email address",
                        placeholder: "example@gmail.com")
        .focused($fieldContent, equals: .email)
        .onSubmit { fieldContent = .password }
        .submitLabel(.next)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        
        CustomTextField(inputData: $currentPassword,
                        title: "Current password",
                        placeholder: "Repeat your current password.",
                        isSecureField: true)
        .focused($fieldContent, equals: .password)
        .onSubmit { fieldContent = .confirmPassword }
        .submitLabel(.next)
        
        ResetBtn {
          Task {
            await authenticationVM.updateEmail(withEmail: email, password: currentPassword)
          }
          return fieldContent = nil
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
      
      .onAppear { fieldContent = .fullName } // Enable the keyboard.
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
    }
  }
}

// MARK: - extensions

extension ResetEmailView: AuthenticationForm {
  var isValidForm: Bool {
    return email.isValidEmail && currentPassword.count > 5
  }
}

#Preview {
  ResetEmailView()
    .environmentObject(AuthenticationViewModel())
}
