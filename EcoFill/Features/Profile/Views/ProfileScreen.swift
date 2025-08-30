//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct ProfileScreen: View {
  @State private var viewModel: ProfileViewModel
  
  init(
    authService: AuthServiceProtocol,
    userService: UserServiceProtocol,
    sessionManager: SessionManager
  ) {
    self._viewModel = State(
      wrappedValue: ProfileViewModel(
        authService: authService,
        userService: userService,
        sessionManager: sessionManager
      )
    )
  }
  
  var body: some View {
    ScrollView {
      VStack {
        // Fake Profile Image
        Image(systemName: "person.crop.circle.fill")
          .font(.system(size: 80))
          .foregroundStyle(.secondary)
          .padding(.bottom)
        
        DefaultTextField(title: "Full name", iconName: "person", text: $viewModel.fullName)
          .textInputAutocapitalization(.words)
        DefaultTextField(title: "Email", iconName: "at", text: $viewModel.email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
        
        CitySelectionView(viewModel: viewModel)
        DeleteAccountButton(viewModel: viewModel)
        SaveChangesButton(viewModel: viewModel)
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
    .onAppear {
      viewModel.retrieveUserData()
    }
  }
}

// MARK: - Subviews

private extension ProfileScreen {
  struct CitySelectionView: View {
    @Bindable var viewModel: ProfileViewModel
    var body: some View {
      DisclosureGroup {
        HStack(spacing: 20) {
          ForEach(City.allCases) { city in
            Button {
              withAnimation(.easeInOut) { viewModel.selectedCity = city }
            } label: {
              Text(city.rawValue)
                .padding(12)
                .background(viewModel.selectedCity == city ? .green : Color(.systemGray5))
                .foregroundStyle(viewModel.selectedCity == city ? .white : .primary)
                .clipShape(.rect(cornerRadius: 15))
            }
            .padding(.top)
          }
        }
      } label: {
        Text("City: **\(viewModel.selectedCity.rawValue)**")
      }
      .padding(13)
      .background(.thinMaterial)
      .clipShape(.rect(cornerRadius: 20))
    }
  }
  struct DeleteAccountButton: View {
    @Bindable var viewModel: ProfileViewModel
    var body: some View {
      Button {
        Task { await viewModel.deleteAccount() }
      } label: {
        Text("Delete account")
          .font(.footnote)
          .fontWeight(.medium)
          .foregroundStyle(.red)
          .underline(true)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding([.top, .leading], 10)
    }
  }
  struct SaveChangesButton: View {
    @Bindable var viewModel: ProfileViewModel
    var body: some View {
      Button {
        Task { await viewModel.updateUser() }
      } label: {
        Text("Save changes")
          .prominentButtonStyle(tint: .blue)
      }
      .padding(.top)
      .disabled(!viewModel.formHasChanges || !viewModel.isValidForm)
      .opacity(!viewModel.formHasChanges || !viewModel.isValidForm ? 0:1)
    }
  }
}

#Preview {
  ProfileScreen(
    authService: AuthService(),
    userService: MockUserService(),
    sessionManager: SessionManager.mockObject
  ).environment(SessionManager.mockObject)
}
