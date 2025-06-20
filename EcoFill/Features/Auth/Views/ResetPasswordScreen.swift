//
//  ForgotPasswordScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct ResetPasswordScreen: View {
  
  @State private var emailAddress = ""
  @State private var isResetLinkSent = false
  @FocusState private var fieldContent: InputContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing: 20) {
          if isResetLinkSent {
            linkSentView
          } else {
            Text("Password Recovery")
              .font(.headline)
              .fontWeight(.bold)
            Text("Enter your email address to receive a password reset link.")
              .font(.subheadline)
              .foregroundStyle(.gray)
              .padding(.horizontal)
            emailTextField.padding(.horizontal)
            sendLinkButton
          }
        Spacer()
      }.padding(.top)
    }
  }
  
  // MARK: - Subviews
  
  private var emailTextField: some View {
    InputField(.email, inputData: $emailAddress)
      .focused($fieldContent, equals: .email)
      .keyboardType(.emailAddress)
      .autocorrectionDisabled(true)
      .textInputAutocapitalization(.never)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
  }
  
  private var sendLinkButton: some View {
    Button {
      Task {
        await authViewModel.sendPasswordResetLink(email: emailAddress)
        withAnimation {
          isResetLinkSent.toggle()
          emailAddress = ""
        }
      }
    } label: {
      ButtonLabel(
        title: "Send Link",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(!emailAddress.isValidEmail)
    .opacity(!emailAddress.isValidEmail ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var linkSentView: some View {
    VStack(spacing: 20) {
      Image(systemName: "checkmark.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.accent)
      Text("Done!")
        .font(.title3)
        .fontWeight(.bold)
      Text("The link has been sent to your email address.")
        .font(.body)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 20)
    }
  }
}

#Preview {
  ResetPasswordScreen()
    .environmentObject(AuthViewModel.previewMode)
}
