//
//  SignUpScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignUpScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  @FocusState private var fieldContent: TextFieldContent?
  
  @State private var city: Cities = .mykolaiv
  @State private var initials: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - Full name
        
        CustomTextField(inputData: $initials,
                        title: "Initials",
                        placeholder: "Tim Cook")
        .focused($fieldContent, equals: .fullName)
        .submitLabel(.next)
        .onSubmit { fieldContent = .email }
        .textInputAutocapitalization(.words)
        
        // MARK: - Email
        
        CustomTextField(inputData: $email,
                        title: "Email",
                        placeholder: "name@example.com")
        .focused($fieldContent, equals: .email)
        .submitLabel(.next)
        .onSubmit { fieldContent = .password }
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        
        // MARK: - Password
        
        CustomTextField(inputData: $password,
                        title: "Password",
                        placeholder: "Must contain at least 6 characters.",
                        isSecureField: true)
        .focused($fieldContent, equals: .password)
        .submitLabel(.next)
        .onSubmit { fieldContent = .confirmPassword }
        
        // MARK: - Confirm Password
        
        CustomTextField(inputData: $confirmPassword,
                        title: "Confirm password",
                        placeholder: "Must match the password.",
                        isSecureField: true)
        .focused($fieldContent,
                 equals: .confirmPassword)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
        
        .overlay(alignment: .trailing) {
          if !password.isEmpty && !confirmPassword.isEmpty {
            let match = password == confirmPassword
            Image(match ? .checkmark : .xmark)
              .defaultSize()
          }
        }
        
        HStack {
          Image(.building)
            .defaultSize()
          Picker("", selection: $city) {
            ForEach(Cities.allCases) { city in
              Text(city.rawValue)
            }
          }
          .tint(.cmReversed)
        }
        
        Spacer()
      }
      .padding(15)
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Sign Up") {
            Task {
              await authenticationVM.createUser(
                withCity: city.rawValue, fullName: initials, email: email, password: password)
            }
          }
          .foregroundStyle(.accent)
          .disabled(!isValidForm)
          .opacity(isValidForm ? 1.0 : 0.5)
        }
      }
    }
  }
}

// MARK: - Extensions

extension SignUpScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !initials.isEmpty
    && email.isValidEmail
    && password.count > 5
    && confirmPassword == password
  }
}

#Preview {
  SignUpScreen()
    .environmentObject(AuthenticationViewModel())
    .environmentObject(FirestoreViewModel())
}

