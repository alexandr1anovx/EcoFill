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
  
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
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
    .navigationTitle("Email Update")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      userVM.checkEmailStatus()
      loadUserEmail()
    }
  }
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $currentEmail,
        iconName: "envelope",
        hint: "Current email address"
      )
      .disabled(true)
      
      DefaultTextField(
        inputData: $newEmail,
        iconName: "envelope",
        hint: "New email address"
      )
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      DefaultTextField(
        inputData: $password,
        iconName: "lock",
        hint: "Current password"
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .listStyle(.insetGrouped)
    .environment(\.defaultMinListRowHeight, 53)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .frame(height: 195)
    .shadow(radius: 1)
  }
  
  private var emailStatusMessage: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack(spacing: 5) {
        Text("Email status:")
          .fontWeight(.medium)
        Text(userVM.emailStatus.message)
          .fontWeight(.bold)
          .foregroundStyle(
            userVM.emailStatus == .verified ? .primaryLime : .red
          )
      }
      .font(.footnote)
      Text(userVM.emailStatus.hint)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .padding(.horizontal, 23)
  }
  
  private var updateEmailButton: some View {
    Button {
      Task {
        await userVM.updateEmail(toEmail: newEmail, withPassword: password)
      }
    } label: {
      ButtonLabel("Update Email", textColor: .primaryText, pouring: .buttonBackground)
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
    .alert(item: $userVM.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private func loadUserEmail() {
    currentEmail = userVM.currentUser?.email ?? "No email address"
  }
}

#Preview {
  UpdateEmailScreen()
    .environmentObject(UserViewModel())
    .environmentObject(StationViewModel())
}
