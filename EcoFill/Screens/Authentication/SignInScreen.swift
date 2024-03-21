//
//  LoginScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct SignInScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @FocusState private var textFieldInputData: TextFieldInputData?
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isPresentedSignUpScreen = false
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 30) {
        // MARK: - Text Fields
        VStack(spacing: 15) {
          CustomTextField(inputData: $email,
                          title: "Email",
                          placeholder: "name@example.com")
          .textInputAutocapitalization(.never)
          .keyboardType(.emailAddress)
          .focused($textFieldInputData, equals: .email)
          .submitLabel(.next)
          .onSubmit { textFieldInputData = .password }
          
          CustomTextField(inputData: $password,
                          title: "Password",
                          placeholder: "At least 6 characters.",
                          isSecureField: true)
          .focused($textFieldInputData, equals: .password)
          .submitLabel(.done)
          .onSubmit { textFieldInputData = nil }
        }
        
      
        // MARK: - 'Sign In' or 'Sign Up'
        VStack(alignment: .leading, spacing: 15) {
          
          Button("Sign In", systemImage: "person.fill.checkmark") {
            Task(priority: .background) {
              await authenticationVM.signIn(withEmail: email, password: password)
            }
          }
          .buttonStyle(CustomButtonModifier(pouring: .accent))
          .disabled(!isValidForm)
          .opacity(isValidForm ? 1.0 : 0.5)
          
          
          HStack {
            Text("Dont have an account?")
              .font(.lexendFootnote)
              .foregroundStyle(.gray)
            
            Button("Sign Up") {
              isPresentedSignUpScreen = true
            }
            .font(.lexendHeadline)
            .foregroundStyle(.blue)
          }
        }
        .shadow(radius: 5)
        
        Spacer()
      }
      .padding(15)
      .navigationTitle("Sign In")
      .navigationBarTitleDisplayMode(.inline)
      
      .sheet(isPresented: $isPresentedSignUpScreen) {
        SignUpScreen()
      }
      
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
    }
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
    .environmentObject(AuthenticationViewModel())
}
