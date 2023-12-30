//
//  SignUpScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

enum FormTextField {
  case fullName, email, city, password, confirmPassword
}

struct SignUpScreen: View {
  @State private var email: String = ""
  @State private var fullName: String = ""
  @State private var city: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  @FocusState private var focusedTextField: FormTextField?
  
  var body: some View {
    VStack {
      Image(systemName: "person.crop.circle.fill.badge.plus")
        .resizable()
        .scaledToFill()
        .foregroundStyle(.customGreen)
        .frame(width: 80, height: 80)
        .padding(.vertical,40)
      
      VStack(spacing:15) {
        // Full name
        CustomTextField(text: $fullName,
                  title: "Ім'я та прізвище",
                  placeholder: "Олександр Пушкін")
        .focused($focusedTextField, equals: .fullName)
        .onSubmit { focusedTextField = .email }
        .submitLabel(.next)
        
        // Email Address
        CustomTextField(text: $email,
                  title: "Електронна пошта",
                  placeholder: "name@example.com")
        .textInputAutocapitalization(.never)
        .keyboardType(.emailAddress)
        .focused($focusedTextField, equals: .email)
        .onSubmit { focusedTextField = .city }
        .submitLabel(.next)
        
        // City
        CustomTextField(text: $city,
                  title: "Ваше місто",
                  placeholder: "Миколаїв")
        .focused($focusedTextField, equals: .city)
        .onSubmit { focusedTextField = .password }
        .submitLabel(.next)
        
        // Password
        CustomTextField(text: $password,
                  title: "Пароль",
                  placeholder: "Не менш ніж шість символів",
                  isSecureField: true)
        .focused($focusedTextField, equals: .password)
        .onSubmit { focusedTextField = .confirmPassword }
        .submitLabel(.next)
        
        // Confirm Password
        ZStack(alignment: .trailing) {
          CustomTextField(text: $confirmPassword,
                    title: "Підтверждення паролю",
                    placeholder: "",
                    isSecureField: true)
          .focused($focusedTextField, equals: .confirmPassword)
          .onSubmit { focusedTextField = nil }
          .submitLabel(.done)
          
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
                .foregroundStyle(.red)
            }
          }
        }
      }
      .padding(.horizontal,25)
      
      HStack(spacing:15) {
        Button("Зареєструватися") {
          Task {
            try await authViewModel.createUser(withEmail:email, 
                                               password:password,
                                               fullName:fullName,
                                               city:city)
          }
        }
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .frame(width: 175, height: 50)
        .background(.customDarkBlue)
        .clipShape(.buttonBorder)
        
        Button("Увійти") {
          dismiss()
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

// MARK: - Extension
extension SignUpScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !fullName.isEmpty
    && !email.isEmpty
    && email.isValidEmail
    && !city.isEmpty
    && !password.isEmpty
    && password.count > 5
    && confirmPassword == password
  }
}

#Preview {
  SignUpScreen()
}
