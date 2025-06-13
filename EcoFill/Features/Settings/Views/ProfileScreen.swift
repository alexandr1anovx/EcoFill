//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct ProfileScreen: View {
  
  // MARK: Properties
  
  @EnvironmentObject var authViewModel: AuthViewModel
  @State private var fullName = ""
  @State private var email = ""
  @State private var accountPassword = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var isShownAccountDeletionAlert = false
  @State private var isShownSavedChangesAlert = false
  @FocusState var inputContent: InputContentType?
  
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  private let validationService = ValidationService.shared

  private var hasChanges: Bool {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot get current user for checking changes.")
      return false
    }
    let changedFullName = fullName != currentUser.fullName
    let changedEmail = email != currentUser.email
    let changedCity = selectedCity.title != currentUser.localizedCity
    
    return changedFullName || changedEmail || changedCity
  }
  
  private var isValidForm: Bool {
    validationService.isValid(fullName: fullName) &&
    (email == authViewModel.currentUser?.email || validationService.isValid(email: email))
  }
  
  // MARK: body
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      ScrollView {
        VStack {
          
          personalDataList
          emailStatusView.padding(.top)
          HStack {
            deleteAccountButton
            Spacer()
            saveChangesButton
          }
          .padding(.horizontal,30)
          .padding(.top,10)
        }
      }
    }
    .alert("Account Deletion", isPresented: $isShownAccountDeletionAlert) {
      SecureField("Your password", text: $accountPassword)
      Button("Cancel", role: .cancel) { accountPassword = "" }
      Button("Delete", role: .destructive) {
        Task {
          await authViewModel.deleteUser(withPassword: accountPassword)
        }
      }
    } message: {
      Text("Are you sure? It will delete all your data forever.")
    }
    // appears when the user changes personal data.
    .alert(item: $authViewModel.alertItem) { alertItem in
      Alert(
        title: alertItem.title,
        message: alertItem.message,
        dismissButton: alertItem.primaryButton
      )
    }
    .onAppear { loadUserData() }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: - Components
  
  private var emailStatusView: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack(spacing: 5) {
        Text("email_status_label")
          .fontWeight(.medium)
        Text(authViewModel.emailStatus.message)
          .fontWeight(.bold)
          .foregroundStyle(
            authViewModel.emailStatus == .verified ? .accent : .red
          )
      }
      .font(.footnote)
      Text(authViewModel.emailStatus.hint)
        .font(.caption)
        .foregroundStyle(.gray)
    }
  }
  
  private var personalDataList: some View {
    List {
      // Full Name
      HStack {
        InputField(for: .fullName, data: $fullName)
          .focused($inputContent, equals: .fullName)
          .textInputAutocapitalization(.words)
        Button("Edit") { inputContent = .fullName }
          .font(.subheadline)
          .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      // Email Address
      HStack {
        InputField(for: .emailAddress, data: $email)
          .focused($inputContent, equals: .emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
        Button("Edit") { inputContent = .emailAddress }
          .font(.subheadline)
          .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      // City
      HStack {
        Image(systemName: "building.2.crop.circle.fill")
          .foregroundStyle(.accent)
        Picker("City:", selection: $selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.title)
          }
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
      }
    }
    .customListStyle(rowHeight: 50, rowSpacing: 10, height: 205, shadow: 1)
  }
  
  private var saveChangesButton: some View {
    Button("Save Changes") {
      Task {
        await authViewModel.updateProfile(
          fullName: fullName,
          email: email,
          city: selectedCity
        )
        feedbackGenerator.notificationOccurred(.success)
        inputContent = nil
      }
    }
    .font(.subheadline)
    .foregroundStyle(.blue)
    .buttonStyle(.bordered)
    .disabled(!hasChanges || !isValidForm)
    .opacity(!hasChanges || !isValidForm ? 0:1)
  }
  
  private var deleteAccountButton: some View {
    Button {
      isShownAccountDeletionAlert.toggle()
      feedbackGenerator.notificationOccurred(.error)
    } label: {
      Text("Delete Account")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  // MARK: Logical Methods
  
  private func loadUserData() {
    guard let user = authViewModel.currentUser else { return }
    fullName = user.fullName
    email = user.email
  }
}

#Preview {
  ProfileScreen()
  .environmentObject(AuthViewModel.previewMode)
}
