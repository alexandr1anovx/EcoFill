//
//  ForgotPasswordScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct ResetPasswordScreen: View {
  
  @State private var email = ""
  @State private var isResetLinkSent = false
  @FocusState private var inputContentType: InputContentType?
  
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
    InputField(.email, inputData: $email)
      .focused($inputContentType, equals: .email)
      .keyboardType(.emailAddress)
      .autocorrectionDisabled(true)
      .textInputAutocapitalization(.never)
      .submitLabel(.done)
      .onSubmit { inputContentType = nil }
  }
  
  private var sendLinkButton: some View {
    Button {
      /*
      Task {
        await authViewModel.sendPasswordResetLink(email: emailAddress)
        withAnimation {
          isResetLinkSent.toggle()
          emailAddress = ""
        }
      }
      */
    } label: {
      ButtonLabel(
        title: "Send Link",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(!email.isValidEmail)
    .opacity(!email.isValidEmail ? 0.5 : 1)
//    .alert(item: $authViewModel.alertItem) { alert in
//      Alert(
//        title: alert.title,
//        message: alert.message,
//        dismissButton: alert.dismissButton
//      )
//    }
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
