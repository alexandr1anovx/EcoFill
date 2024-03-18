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
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  
  @State private var city: Cities = .mykolaiv
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  @FocusState private var textFieldInputData: TextFieldInputData?
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 30) {
        // MARK: - Text Fields
        VStack(alignment: .leading, spacing: 15) {
          HStack {
            Text("City:")
              .font(.lexendCallout)
            Picker("", selection: $city) {
              ForEach(Cities.allCases) { city in
                Text(city.rawValue)
              }
            }
            .tint(.cmReversed)
          }
          
          Divider()
          
          // MARK: - Full name
          CustomTextField(inputData: $fullName,
                          title: "Full Name",
                          placeholder: "Tim Cook")
          .focused($textFieldInputData, equals: .fullName)
          .submitLabel(.next)
          .onSubmit { textFieldInputData = .email }
          .textInputAutocapitalization(.words)
          
          // MARK: - Email
          CustomTextField(inputData: $email,
                          title: "Email",
                          placeholder: "name@example.com")
          .textInputAutocapitalization(.never)
          .keyboardType(.emailAddress)
          .focused($textFieldInputData, equals: .email)
          .submitLabel(.next)
          .onSubmit { textFieldInputData = .password }
          
          // MARK: - Password
          CustomTextField(inputData: $password,
                          title: "Password",
                          placeholder: "At least 6 characters.",
                          isSecureField: true)
          .focused($textFieldInputData, equals: .password)
          .submitLabel(.next)
          .onSubmit { textFieldInputData = .confirmPassword }
          
          // MARK: - Confirm Password
          ZStack(alignment: .trailing) {
            CustomTextField(inputData: $confirmPassword,
                            title: "Confirm password",
                            placeholder: "Must match the password.",
                            isSecureField: true)
            .focused($textFieldInputData,
                     equals: .confirmPassword)
            .submitLabel(.done)
            .onSubmit { textFieldInputData = nil }
            
            if !password.isEmpty && !confirmPassword.isEmpty {
              let match = password == confirmPassword
              let displayedImage = match ? "checkmark" : "xmark"
              
              Image(displayedImage)
                .defaultSize()
            }
          }
        }
        
        Button("Sign Up", systemImage: "person.fill.badge.plus") {
          Task {
            try await authenticationVM.createUser(withCity: city.rawValue, fullName: fullName, email: email, password: password)
          }
        }
        .buttonStyle(CustomButtonModifier(pouring: .blue))
        .disabled(!isValidForm)
        .opacity(isValidForm ? 1.0 : 0.5)
        .shadow(radius: 5)
        
        // MARK: - Spacer
        Spacer()
      }
      .padding(15)
      .navigationTitle("Sign Up")
      .navigationBarTitleDisplayMode(.inline)
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          DismissXButton()
        }
      }
    }
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

