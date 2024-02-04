//
//  LoginScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignInScreen: View {
  
  // MARK: - Properties
  @State private var email: String = ""
  @State private var password: String = ""
  @EnvironmentObject var authViewModel: AuthViewModel
  @FocusState private var focusedTextField: FormTextField?
  @State private var isShowingSignUpScreen: Bool = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "person.crop.rectangle.badge.plus.fill")
          .resizable()
          .scaledToFit()
          .foregroundStyle(.accent)
          .frame(width: 80, height: 80)
          .padding(.vertical,30)
        
        // MARK: - Input View for Password and Email
        VStack(spacing:20) {
          CustomTextField(text: $email,
                    title: "Email",
                    placeholder: "name@example.com")
          .textInputAutocapitalization(.never)
          .keyboardType(.emailAddress)
          .focused($focusedTextField, equals: .email)
          .onSubmit { focusedTextField = .password }
          .submitLabel(.next)
          
          CustomTextField(text: $password,
                    title: "Password",
                    placeholder: "At least 6 characters.",
                    isSecureField: true)
          .focused($focusedTextField, equals: .password)
          .onSubmit { focusedTextField = nil }
          .submitLabel(.done)
        }
        .padding(.horizontal,25)
        
        
        // MARK: 'Sign In' and 'Sign Up' buttons
        HStack(spacing:15) {
          CustomButton(title: "Sign In", bgColor: .defaultBlack) {
            Task {
              try await authViewModel.signIn(withEmail:email, password:password)
            }
          }
          .disabled(!isValidForm)
          .opacity(isValidForm ? 1.0 : 0.5)
          
          CustomButton(title: "Sign Up", bgColor: .accent) {
            isShowingSignUpScreen.toggle()
          }
          .sheet(isPresented: $isShowingSignUpScreen) {
            SignUpScreen()
              .presentationDetents([.large])
              .presentationDragIndicator(.visible)
          }
        }
        .padding(.top,40)
        
        Spacer()
      } // v
    } // nav
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
