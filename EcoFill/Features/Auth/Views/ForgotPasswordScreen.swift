//
//  ForgotPasswordScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct ForgotPasswordScreen: View {
  
  @State private var email = ""
  @State private var isResetLinkSent = false
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 0) {
          
          if isResetLinkSent {
            successView
          } else {
            Text("Reset password.")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundStyle(.primaryLabel)
              .padding(.top, 25)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 23)
            
            Text("Enter your email to receive a password reset link.")
              .font(.headline)
              .fontWeight(.medium)
              .foregroundStyle(.gray)
              .padding(.top, 5)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 23)
            textField
            sendLinkButton.padding(.top, 20)
          }
        Spacer()
      }
    }
    .onTapGesture {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  private var textField: some View {
    List {
      DefaultTextField(
        inputData: $email,
        iconName: "envelope",
        hint: "Email address"
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .autocorrectionDisabled(true)
      .textInputAutocapitalization(.never)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollDisabled(true)
    .frame(height: 90)
    .environment(\.defaultMinListRowHeight, 53)
    .shadow(radius: 1)
  }
  
  private var sendLinkButton: some View {
    Button {
      Task {
        await authViewModel.sendPasswordReset(to: email)
        withAnimation {
          isResetLinkSent.toggle()
          email = ""
        }
      }
    } label: {
      ButtonLabel(
        "Send Reset Link",
        textColor: .primaryText,
        pouring: .buttonBackground
      )
    }
    .disabled(!email.isValidEmail)
    .opacity(!email.isValidEmail ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var successView: some View {
    VStack(spacing: 20) {
      Image(systemName: "checkmark.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.green)
      
      Text("Reset Link Sent")
        .font(.title3)
        .fontWeight(.bold)
      
      Text("Check your email for instructions to reset your password.")
        .font(.body)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 20)
      
      Button {
        dismiss()
      } label: {
        Text("Back to Sign In")
          .font(.headline)
          .foregroundStyle(.primaryLabel)
          .padding(.vertical, 12)
          .padding(.horizontal, 30)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.primaryIcon, lineWidth: 2)
          )
      }.padding(.top,10)
    }
  }
}

#Preview {
  ForgotPasswordScreen()
    .environmentObject( AuthViewModel() )
}

