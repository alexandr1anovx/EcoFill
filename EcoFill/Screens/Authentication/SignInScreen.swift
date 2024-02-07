//
//  LoginScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignInScreen: View {
  // MARK: - Properties
  @EnvironmentObject var authViewModel: AuthViewModel
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isShowingSignUpScreen: Bool = false
  @FocusState private var registrationFormTF: RegistrationFormTextField?
  
  // MARK: - body
  var body: some View {
    VStack(spacing:20) {
      Image(systemName: "person.crop.rectangle.badge.plus.fill")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.accent)
        .frame(width: 100, height: 100)
      
      // MARK: - User Input Data
      
      CustomTextField(text: $email,
                      title: "Email",
                      placeholder: "name@example.com")
      .textInputAutocapitalization(.never)
      .keyboardType(.emailAddress)
      .focused($registrationFormTF, equals: .email)
      .submitLabel(.next)
      .onSubmit { registrationFormTF = .password }
      
      
      CustomTextField(text: $password,
                      title: "Password",
                      placeholder: "At least 6 characters.",
                      isSecureField: true)
      .focused($registrationFormTF, equals: .password)
      .submitLabel(.done)
      .onSubmit { registrationFormTF = nil }
    }
    .padding(.horizontal,20)
    .padding(.vertical,20)
    
    // MARK: - 'Sign In' and 'Sign Up' buttons
    
    HStack(spacing:15) {
      CustomButton(title: "Sign In", bgColor: .defaultBlack) {
        Task {
          try await authViewModel.signIn(withEmail:email, password:password)
        }
      }
      .disabled(!isValidForm)
      .opacity(isValidForm ? 1.0 : 0.5)
      
      CustomButton(title: "Sign Up", bgColor: .accent) {
        isShowingSignUpScreen = true
      }
      .sheet(isPresented: $isShowingSignUpScreen) {
        SignUpScreen()
          .presentationDetents([.large])
          .presentationDragIndicator(.visible)
      }
    }
    .padding(.top,30)
    
    Spacer()
  }
}

// MARK: - Authentication Form Protocol
extension SignInScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !email.isEmpty
    && email.isValidEmail
    && !password.isEmpty
    && password.count > 5
  }
}

#Preview {
  SignInScreen()
}
