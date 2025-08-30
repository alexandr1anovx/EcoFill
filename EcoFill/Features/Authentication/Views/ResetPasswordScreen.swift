//
//  ForgotPasswordScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct ResetPasswordScreen: View {
  @Environment(\.dismiss) var dismiss
  @State private var email = ""
  @State private var isLoading = false
  @State private var showAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  
  var body: some View {
    VStack(spacing: 20) {
      
      VStack(spacing: 15) {
        Image(systemName: "lock.circle.fill")
          .font(.system(size: 40))
        Text("Reset Password")
          .font(.title)
          .fontWeight(.semibold)
        Text("Enter your email address and we'll send you a link to get back into your account.")
          .font(.subheadline)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
      }
      .padding(.bottom, 15)
      
      DefaultTextField(
        title: "Email address",
        iconName: "at",
        text: $email
      )
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      
      Button {
        // ⚠️ add an action to send email reset link.
        email = ""
        dismiss()
      } label: {
        Text("Send Reset Link")
          .prominentButtonStyle(tint: .green)
      }
      .padding(.horizontal)
      .disabled(email.isEmpty)
      .opacity(email.isEmpty ? 0.5 : 1)
      
      Spacer()
    }
    .padding()
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text(alertTitle),
        message: Text(alertMessage),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}
