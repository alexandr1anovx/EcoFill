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
  
  var body: some View {
    NavigationStack {
      VStack {
        Image("signIn")
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100)
          .padding(.vertical,30)
          .shadow(radius: 30)
          .opacity(0.8)
        
        // TextFields for email and password
        VStack(spacing: 20) {
          InputView(text: $email,
                    title: "Електронна пошта",
                    placeholder: "name@example.com")
          .textInputAutocapitalization(.never)
          
          InputView(text: $password,
                    title: "Пароль",
                    placeholder: "Не менш ніж шість символів",
                    isSecureField: true)
        }
        .padding(.horizontal,20)
        .padding(.top,30)
        
        // Sign In button
        Button("Увійти") {
          Task { 
            try await authViewModel.signIn(withEmail:email,password:password)
          }
        }
        .foregroundStyle(.white)
        .frame(width: UIScreen.main.bounds.width - 100, height: 50)
        .disabled(!isValidForm)
        .background(Color.grGreenDarkBlue)
        .clipShape(.buttonBorder)
        .opacity(isValidForm ? 1.0 : 0.5)
        .padding(.top,40)
        
        Spacer()
        
        NavigationLink("Зареєструватися") {
          SignUpScreen()
            .navigationBarBackButtonHidden(true)
        }
        .fontWeight(.medium)
        .tint(.customSystemReversed)
        .buttonStyle(.bordered)
        .opacity(0.8)
        .padding(.bottom,20)
      }
    }
  }
}

// MARK: - AuthenticationForm Protocol
extension SignInScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count > 5
  }
}

#Preview {
  SignInScreen()
}

