//
//  LoginScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignInScreen: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @EnvironmentObject var authViewModel: AuthViewModel
  @FocusState private var focusedTextField: FormTextField?
  
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "person.crop.rectangle.badge.plus.fill")
          .resizable()
          .scaledToFill()
          .foregroundStyle(.customGreen)
          .frame(width: 80, height: 80)
          .padding(.vertical,40)
        
        // MARK: - Input View for Password and Email
        VStack(spacing:20) {
          CustomTextField(text: $email,
                    title: "Електронна пошта",
                    placeholder: "name@example.com")
          .textInputAutocapitalization(.never)
          .keyboardType(.emailAddress)
          .focused($focusedTextField, equals: .email)
          .onSubmit { focusedTextField = .password }
          .submitLabel(.next)
          
          CustomTextField(text: $password,
                    title: "Пароль",
                    placeholder: "Не менш ніж шість символів",
                    isSecureField: true)
          .focused($focusedTextField, equals: .password)
          .onSubmit { focusedTextField = nil }
          .submitLabel(.done)
        }
        .padding(.horizontal,25)
        
        
        // MARK: 'Sign In' and 'Sign Up' buttons
        HStack(spacing:15) {
          Button("Увійти") {
            Task {
              try await authViewModel.signIn(withEmail:email,
                                             password:password)
            }
          }
          .fontWeight(.medium)
          .foregroundStyle(.white)
          .frame(width: 175, height: 50)
          .background(.customDarkBlue)
          .clipShape(.buttonBorder)
          .disabled(!isValidForm)
          .opacity(isValidForm ? 1.0 : 0.6)
          
          NavigationLink("Зареєструватися") {
            SignUpScreen()
              .navigationBarBackButtonHidden(true)
          }
          .fontWeight(.medium)
          .foregroundStyle(.white)
          .frame(width: 175, height: 50)
          .background(.customGreen)
          .clipShape(.buttonBorder)
        }
        .padding(.top,30)
        .shadow(radius:10)
        
        Spacer()
      }
    }
  }
}

// MARK: - AuthenticationForm Protocol
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
