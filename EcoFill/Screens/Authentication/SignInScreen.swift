//
//  LoginScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignInScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @FocusState private var fieldContent: TextFieldContent?
  
  @State private var email: String = ""
  @State private var password: String = ""
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - TextFields
        
        CustomTextField(inputData: $email,
                        title: "Email",
                        placeholder: "Email from your account.")
        .textInputAutocapitalization(.never)
        .keyboardType(.emailAddress)
        .focused($fieldContent, equals: .email)
        .submitLabel(.next)
        .onSubmit { fieldContent = .password }
        
        CustomTextField(inputData: $password,
                        title: "Password",
                        placeholder: "Password for your account.",
                        isSecureField: true)
        .focused($fieldContent, equals: .password)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
        
        // MARK: - Sign In
        
        SignInBtn {
          Task {
            await authenticationVM.signIn(
              withEmail: email, password: password)
          }
        }
        .disabled(!isValidForm)
        .opacity(isValidForm ? 1.0 : 0.5)
        
        HStack {
          Text("Dont have an account?")
            .font(.lexendFootnote)
            .foregroundStyle(.gray)
          
          NavigationLink("Sign Up") {
            SignUpScreen()
          }
          .font(.lexendHeadline)
          .foregroundStyle(.brown)
        }
        
        Spacer()
      }
      .padding(15)
      .navigationTitle("Sign In")
      .navigationBarTitleDisplayMode(.inline)
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
    }
  }
}

// MARK: - Extensions

extension SignInScreen: AuthenticationForm {
  var isValidForm: Bool {
    return email.isValidEmail && password.count > 5
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthenticationViewModel())
}
