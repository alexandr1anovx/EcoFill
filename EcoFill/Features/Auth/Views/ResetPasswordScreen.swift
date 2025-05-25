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
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing: 20) {
          if isResetLinkSent {
            linkSentView
          } else {
            Text("reset_password_title")
              .font(.headline)
              .fontWeight(.bold)
            Text("reset_password_subtitle")
              .font(.subheadline)
              .foregroundStyle(.gray)
              .padding(.horizontal)
            emailTextField
            sendLinkButton
          }
        Spacer()
      }.padding(.top)
    }
  }
  
  // MARK: - UI Components
  
  private var emailTextField: some View {
    List {
      DefaultTextField(
        inputData: $email,
        iconName: "envelope",
        hint: "input_email"
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .autocorrectionDisabled(true)
      .textInputAutocapitalization(.never)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .customListStyle(rowHeight: 50, scrollDisabled: true, height: 85, shadow: 1)
  }
  
  private var sendLinkButton: some View {
    Button {
      Task {
        await authViewModel.sendPasswordResetLink(email: email)
        withAnimation {
          isResetLinkSent.toggle()
          email = ""
        }
      }
    } label: {
      ButtonLabel(
        title: "send_reset_link_button",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(!email.isValidEmail)
    .opacity(!email.isValidEmail ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.primaryButton
      )
    }
  }
  
  private var linkSentView: some View {
    VStack(spacing: 20) {
      Image(systemName: "checkmark.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.accent)
      Text("sent_link_title")
        .font(.title3)
        .fontWeight(.bold)
      Text("sent_link_message")
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
