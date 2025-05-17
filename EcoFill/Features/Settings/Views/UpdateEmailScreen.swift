//
//  UpdateEmailScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.03.2025.
//

import SwiftUI

struct UpdateEmailScreen: View {
  
  @State private var currentEmail = ""
  @State private var newEmail = ""
  @State private var password = ""
  @State private var isShownConfirmationAlert = false
  
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    newEmail.isValidEmail && password.count > 5
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(alignment: .leading, spacing: 20) {
        textFields
        emailStatusMessage
        updateEmailButton
        Spacer()
      }
    }
    .navigationTitle("updateEmail_title")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      authViewModel.checkEmailStatus()
      loadUserEmail()
    }
  }
  
  // MARK: Auxilary UI Components
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $currentEmail,
        iconName: "envelope",
        hint: "input_email_current"
      )
      .disabled(true)
      
      DefaultTextField(
        inputData: $newEmail,
        iconName: "envelope",
        hint: "input_email_new"
      )
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      DefaultTextField(
        inputData: $password,
        iconName: "lock",
        hint: "input_password_current"
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .frame(height: 195)
    .shadow(radius: 1)
  }
  
  private var emailStatusMessage: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack(spacing: 5) {
        Text("email_status_label")
          .fontWeight(.medium)
        Text(authViewModel.emailStatus.message)
          .fontWeight(.bold)
          .foregroundStyle(
            authViewModel.emailStatus == .verified ? .primaryLime : .red
          )
      }
      .font(.footnote)
      Text(authViewModel.emailStatus.hint)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .padding(.horizontal, 23)
  }
  
  private var updateEmailButton: some View {
    Button {
      Task {
        await authViewModel.updateEmail(toEmail: newEmail, withPassword: password)
        password = ""
      }
    } label: {
      ButtonLabel(
        title: "update_email_button",
        textColor: .primaryText,
        pouring: .buttonBackground
      )
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private func loadUserEmail() {
    currentEmail = authViewModel.currentUser?.email ?? "no_email_address"
  }
}

#Preview {
  UpdateEmailScreen()
    .environmentObject(AuthViewModel())
    .environmentObject(MapViewModel())
}
