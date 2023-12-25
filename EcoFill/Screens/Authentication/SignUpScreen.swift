//
//  SignUpScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignUpScreen: View {
  @State private var email: String = ""
  @State private var fullName: String = ""
  @State private var city: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    VStack {
      Image("signUp")
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
        .padding(.vertical,20)
        .shadow(radius: 30)
        .opacity(0.8)
      
      VStack(spacing: 15) {
        // Full name
        InputView(text: $fullName,
                  title: "Ім'я та прізвище",
                  placeholder: "Олександр Пушкін")
        
        // Email Address
        InputView(text: $email,
                  title: "Електронна пошта",
                  placeholder: "name@example.com")
        .textInputAutocapitalization(.never)
        
        // City
        InputView(text: $city,
                  title: "Ваше місто",
                  placeholder: "Миколаїв")
        
        // Password
        InputView(text: $password,
                  title: "Пароль",
                  placeholder: "Не менш ніж шість символів",
                  isSecureField: true)
        
        ZStack(alignment: .trailing) {
          // Confirm Password
          InputView(text: $confirmPassword,
                    title: "Підтверждення паролю",
                    placeholder: "",
                    isSecureField: true)
          
          if !password.isEmpty && !confirmPassword.isEmpty {
            if password == confirmPassword {
              Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(.customGreen)
            } else {
              Image(systemName: "xmark.circle.fill")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundStyle(.customRed)
            }
          }
        }
      }
      .padding(.horizontal,20)
      .padding(.top,15)
      
      // SIGN IN button
      Button("Зареєструватися") {
        Task {
          try await authViewModel.createUser(withEmail:email, password:password, fullName:fullName, city:city)
        }
      }
      .foregroundStyle(.white)
      .frame(width: UIScreen.main.bounds.width - 100, height: 50)
      .disabled(!isValidForm)
      .background(Color.grOrangeDarkBlue)
      .clipShape(.buttonBorder)
      .opacity(isValidForm ? 1.0 : 0.5)
      .padding(.top,20)
      
      Spacer()
      
      Button("Увійти") {
        dismiss()
      }
      .fontWeight(.medium)
      .tint(.customSystemReversed)
      .buttonStyle(.bordered)
      .opacity(0.8)
      .padding(.bottom,20)
    }
  }
}

// MARK: - Extension
extension SignUpScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !fullName.isEmpty
    && !email.isEmpty
    && email.contains("@")
    && !city.isEmpty
    && !password.isEmpty
    && password.count > 5
    && confirmPassword == password
  }
}

#Preview {
  SignUpScreen()
}


