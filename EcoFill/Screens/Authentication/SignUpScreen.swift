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
  
  // MARK: - Properties
  @State private var email: String = ""
  @State private var fullName: String = ""
  @State private var city: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  @FocusState private var focusedTextField: FormTextField?
  
  // MARK: - body
  var body: some View {
    VStack {
      Image(systemName: "person.crop.circle.fill.badge.plus")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.accent)
        .frame(width: 80, height: 80)
        .padding(.vertical,30)
      
      VStack(spacing:15) {
        // Full name
        CustomTextField(text: $fullName,
                  title: "Full Name",
                  placeholder: "Tim Cook")
        .focused($focusedTextField, equals: .fullName)
        .onSubmit { focusedTextField = .email }
        .submitLabel(.next)
        
        // Email Address
        CustomTextField(text: $email,
                  title: "Email",
                  placeholder: "name@example.com")
        .textInputAutocapitalization(.never)
        .keyboardType(.emailAddress)
        .focused($focusedTextField, equals: .email)
        .onSubmit { focusedTextField = .city }
        .submitLabel(.next)
        
        // City
        CustomTextField(text: $city,
                  title: "City",
                  placeholder: "Kyiv")
        .focused($focusedTextField, equals: .city)
        .onSubmit { focusedTextField = .password }
        .submitLabel(.next)
        
        // Password
        CustomTextField(text: $password,
                  title: "Password",
                  placeholder: "At least 6 characters.",
                  isSecureField: true)
        .focused($focusedTextField, equals: .password)
        .onSubmit { focusedTextField = .confirmPassword }
        .submitLabel(.next)
        
        // Confirm Password
        ZStack(alignment: .trailing) {
          CustomTextField(text: $confirmPassword,
                    title: "Confirm password",
                    placeholder: "Must match the password.",
                    isSecureField: true)
          .focused($focusedTextField, equals: .confirmPassword)
          .onSubmit { focusedTextField = nil }
          .submitLabel(.done)
          
          if !password.isEmpty && !confirmPassword.isEmpty {
            let imageName = (password == confirmPassword) ? "checkmark.circle.fill" : "xmark.circle.fill"
            let color = (password == confirmPassword) ? Color.accentColor : Color.red
            
            Image(systemName: imageName)
              .imageScale(.large)
              .fontWeight(.semibold)
              .foregroundStyle(color)
          }
        }
      }
      .padding(.horizontal,20)
      
      HStack(spacing:20) {
        CustomButton(title: "Sign Up", bgColor: .accent) {
          Task {
            try await authViewModel.createUser(withEmail:email, password:password, fullName:fullName, city:city)
          }
        }
        CustomButton(title: "Back", bgColor: .defaultBlack) {
          dismiss()
        }
      }
      .padding(.top,30)
      
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
