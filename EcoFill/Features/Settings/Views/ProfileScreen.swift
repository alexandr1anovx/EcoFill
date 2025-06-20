//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct ProfileScreen: View {
  
  @State private var fullName = ""
  @State private var email = ""
  @State private var accountPassword = ""
  @State private var isExpanded = false
  @State private var selectedCity: City = .mykolaiv
  @State private var isShownAccountDeletionAlert = false
  @State private var isShownSavedChangesAlert = false
  @FocusState var inputContent: InputContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - Computed Properties
  
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  private let validationService = ValidationService()
  
  private var hasChanges: Bool {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot get current user for checking changes.")
      return false
    }
    let changedFullName = fullName != currentUser.fullName
    let changedEmail = email != currentUser.email
    let changedCity = selectedCity.rawValue != currentUser.city
    
    return changedFullName || changedEmail || changedCity
  }
  
  private var isValidForm: Bool {
    validationService.isValid(fullName: fullName) &&
    (email == authViewModel.currentUser?.email || validationService.isValid(email: email))
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      ScrollView {
        VStack(alignment: .leading,spacing:0) {
          Section {
            VStack {
              inputFields
              CitySelectionView(isExpanded: $isExpanded, selectedCity: $selectedCity)
              if hasChanges {
                HStack {
                  Spacer()
                  saveChangesButton
                }
              }
            }
          } header: {
            Text("Personal Data")
              .font(.callout)
              .fontWeight(.bold)
          }
          .padding(.vertical)
          
          Divider()
          
          Section {
            emailStatusView
          } header: {
            Text("Email Status")
              .font(.callout)
              .fontWeight(.bold)
          }
          .padding(.vertical)
          
          Divider()
          
          Section {
            HStack {
              deleteAccountButton
              Spacer()
            }
          } header: {
            Text("Additional Actions")
              .font(.callout)
              .fontWeight(.bold)
          }
          .padding(.top)
          
          Spacer()
        }
        .padding(.horizontal)
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
          dismissButton: alertItem.dismissButton
        )
      }
      .onAppear { loadUserData() }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
      }
  }
  
  // MARK: - Subviews
  
  private var inputFields: some View {
    VStack(alignment: .leading) {
      InputField(.fullName, inputData: $fullName)
        .focused($inputContent, equals: .fullName)
        .textInputAutocapitalization(.words)
      InputField(.email, inputData: $email)
        .focused($inputContent, equals: .email)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
  }
  
  private var emailStatusView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(authViewModel.emailStatus.title)
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(
          authViewModel.emailStatus == .verified ? .accent : .red
        )
      Text(authViewModel.emailStatus.message)
        .font(.caption)
        .foregroundStyle(.gray)
    }
  }
  
  private var saveChangesButton: some View {
    Button("Save Changes") {
      Task {
        await authViewModel.updateProfile(
          fullName: fullName,
          email: email,
          city: selectedCity.rawValue
        )
      }
      inputContent = nil
      if isExpanded {
        withAnimation {
          isExpanded = false
        }
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
  
  // MARK: - Methods
  
  private func loadUserData() {
    guard let user = authViewModel.currentUser else { return }
    fullName = user.fullName
    email = user.email
    selectedCity = City(rawValue: user.city) ?? .odesa
  }
}

#Preview {
  ProfileScreen()
    .environmentObject(AuthViewModel.previewMode)
}
