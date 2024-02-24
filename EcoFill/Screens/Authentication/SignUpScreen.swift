//
//  SignUpScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

enum TextFieldInputData {
  case fullName, email, password, confirmPassword
}

enum Cities: String, Identifiable, CaseIterable {
  case kyiv = "Kyiv"
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
  
  var id: Self { self }
}

struct SignUpScreen: View {
  
  // MARK: - Properties
  @State private var city: Cities = .mykolaiv
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  
  @FocusState private var textFieldInputData: TextFieldInputData?
  
  var body: some View {
    VStack(spacing:15) {
      HStack {
        Text("City:")
          .font(.callout)
          .fontWeight(.semibold)
          .fontDesign(.rounded)
        Picker("", selection: $city) {
          ForEach(Cities.allCases) { city in
            Text(city.rawValue)
          }
        }
        .pickerStyle(.menu)
        .tint(.defaultReversed)
        
        Spacer()
      }
      .padding(.top,10)
      
      Divider()
      
      // MARK: - Full name
      CustomTextField(text: $fullName,
                      title: "Full Name",
                      placeholder: "Tim Cook")
      .focused($textFieldInputData, equals: .fullName)
      .submitLabel(.next)
      .onSubmit {
        textFieldInputData = .email
      }
      
      // MARK: - Email
      CustomTextField(text: $email,
                      title: "Email",
                      placeholder: "name@example.com")
      .textInputAutocapitalization(.never)
      .keyboardType(.emailAddress)
      .focused($textFieldInputData, equals: .email)
      .submitLabel(.next)
      .onSubmit {
        textFieldInputData = .password
      }
      
      // MARK: - Password
      CustomTextField(text: $password,
                      title: "Password",
                      placeholder: "At least 6 characters.",
                      isSecureField: true)
      .focused($textFieldInputData, equals: .password)
      .submitLabel(.next)
      .onSubmit {
        textFieldInputData = .confirmPassword
      }
      
      // MARK: - Confirm Password
      ZStack(alignment: .trailing) {
        CustomTextField(text: $confirmPassword,
                        title: "Confirm password",
                        placeholder: "Must match the password.",
                        isSecureField: true)
        .focused($textFieldInputData,
                 equals: .confirmPassword)
        .submitLabel(.done)
        .onSubmit {
          textFieldInputData = nil
        }
        
        if !password.isEmpty && !confirmPassword.isEmpty {
          let match = password == confirmPassword
          let displayedImage = match ? "checkmark.circle.fill" : "xmark.circle.fill"
          let color: Color = match ? .accentColor : .red
          
          Image(systemName: displayedImage)
            .imageScale(.large)
            .foregroundStyle(color)
        }
      }
    }
    .padding(20)
    
    // MARK: - Sign Up
    VStack(spacing:20) {
      CustomButton(title: "Sign Up", imageName: "person.fill.badge.plus", bgColor: .defaultOrange) {
        Task {
          try await authenticationVM.createUser(withCity: city.rawValue, fullName: fullName, email: email, password: password)
        }
      }
      .disabled(!isValidForm)
      .opacity(isValidForm ? 1.0 : 0.5)
      
      HStack {
        Text("Already have an account?")
          .font(.callout)
        NavigationLink("Sign In") {
          SignUpScreen()
        }
        .font(.headline)
        .foregroundStyle(.accent)
      }
    }
    .navigationTitle("Sign Up")
    .navigationBarTitleDisplayMode(.inline)
    
    // MARK: - Alerts
    .alert(item: $authenticationVM.alertItem) { alertItem in
      Alert(title: alertItem.title,
            message: alertItem.message,
            dismissButton: alertItem.dismissButton)
    }
    Spacer()
  }
}

// MARK: - Extensions
extension SignUpScreen: AuthenticationForm {
  var isValidForm: Bool {
    return !fullName.isEmpty
    && !email.isEmpty && email.isValidEmail
    && !password.isEmpty && password.count > 5
    && confirmPassword == password
  }
}

#Preview {
  SignUpScreen()
    .environmentObject(AuthenticationViewModel())
    .environmentObject(FirestoreViewModel())
}
