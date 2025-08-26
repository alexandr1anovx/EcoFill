//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct ProfileScreen: View {
  @Environment(SessionManager.self) var sessionManager
  @State private var viewModel: ProfileViewModel
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self._viewModel = State(
      wrappedValue: ProfileViewModel(
        authService: authService,
        userService: userService
      )
    )
  }
  
  var body: some View {
    ScrollView {
      VStack {
        VStack {
          InputField(.fullName, inputData: $viewModel.fullName)
            .textInputAutocapitalization(.words)
          InputField(.email, inputData: $viewModel.email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
          CitySelectionView(
            isExpanded: $viewModel.isExpanded,
            selectedCity: $viewModel.selectedCity
          )
        }
        Button("Sign Out") {
          viewModel.signOut()
        }
        Button {
          // save changes action
        } label: {
          Text("Save changes")
        }
        Button {
          // delete account action
        } label: {
          Text("Delete account")
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        Spacer()
      }
      .padding(.horizontal)
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .alert(item: $viewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
    .onAppear { retrieveUserData() }
  }
}

// MARK: - Additional Methods
private extension ProfileScreen {
  private func retrieveUserData() {
    guard let user = sessionManager.currentUser else { return }
    viewModel.fullName = user.fullName
    viewModel.email = user.email
    viewModel.selectedCity = City(rawValue: user.city) ?? .mykolaiv
  }
}
