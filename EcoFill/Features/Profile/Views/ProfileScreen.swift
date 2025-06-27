//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.06.2025.
//

import SwiftUI

struct ProfileScreen: View {
  
  @State private var isShownLogoutAlert = false
  @FocusState var inputContent: InputContentType?
  @EnvironmentObject var sessionManager: SessionManager
  @StateObject private var viewModel: ProfileViewModel
  
  init(
    firebaseAuthService: AuthServiceProtocol,
    firestoreUserService: UserServiceProtocol,
    sessionManager: SessionManager
  ) {
    _viewModel = StateObject(wrappedValue: ProfileViewModel(
      firebaseAuthService: firebaseAuthService,
      firestoreUserService: firestoreUserService,
      sessionManager: sessionManager
    ))
  }
  
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      ScrollView {
        VStack(alignment: .leading,spacing:0) {
          Section {
            VStack {
              inputFields
              CitySelectionView(
                isExpanded: $viewModel.isExpanded,
                selectedCity: $viewModel.selectedCity
              )
              if viewModel.isFormHasChanges {
                HStack {
                  if viewModel.isLoading {
                    ProgressView()
                  }
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
            //emailStatusView
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
          
          signOutButton
        }
        .padding(.horizontal)
      }
      .alert(item: $viewModel.alertItem) { alert in
        Alert(
          title: alert.title,
          message: alert.message,
          dismissButton: alert.dismissButton
        )
      }
      .alert("Account Deletion", isPresented: $viewModel.isShownAccountDeletionAlert) {
        SecureField("Your password", text: $viewModel.accountPassword)
        Button("Cancel", role: .cancel) { viewModel.accountPassword = "" }
        Button("Delete", role: .destructive) {
          Task { await viewModel.deleteAccount() }
        }
      } message: {
        Text("Are you sure? It will delete all your data forever.")
      }
      .onAppear {
        loadUserData()
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
      }
  }
  
  // MARK: - Subviews
  
  private var inputFields: some View {
    VStack(alignment: .leading) {
      InputField(.fullName, inputData: $viewModel.fullName)
        .focused($inputContent, equals: .fullName)
        .textInputAutocapitalization(.words)
      InputField(.email, inputData: $viewModel.email)
        .focused($inputContent, equals: .email)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
  }
  
//  private var emailStatusView: some View {
//    VStack(alignment: .leading, spacing: 8) {
//      Text(authViewModel.emailStatus.title)
//        .font(.footnote)
//        .fontWeight(.medium)
//        .foregroundStyle(
//          authViewModel.emailStatus == .verified ? .accent : .red
//        )
//      Text(authViewModel.emailStatus.message)
//        .font(.caption)
//        .foregroundStyle(.gray)
//    }
//  }
  
  private var saveChangesButton: some View {
    Button("Save Changes") {
      Task { await viewModel.updateUser() }
    }
    .font(.subheadline)
    .foregroundStyle(.blue)
    .buttonStyle(.bordered)
    .disabled(!viewModel.isFormHasChanges || !viewModel.isValidForm)
    .opacity(!viewModel.isFormHasChanges || !viewModel.isValidForm ? 0:1)
  }
  
  private var deleteAccountButton: some View {
    Button {
      viewModel.isShownAccountDeletionAlert.toggle()
      feedbackGenerator.notificationOccurred(.error)
    } label: {
      Text("Delete Account")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  private var signOutButton: some View {
    Button {
      isShownLogoutAlert.toggle()
    } label: {
      Text("Sign Out")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
    }
    .alert("Sign Out", isPresented: $isShownLogoutAlert) {
      Button("Sign Out", role: .destructive) {
        viewModel.signOut()
      }
    } message: {
      Text("This action will redirect you to the login screen.")
    }
  }
  
  // MARK: - Methods
  private func loadUserData() {
    guard let user = sessionManager.currentUser else { return }
    viewModel.fullName = user.fullName
    viewModel.email = user.email
    viewModel.selectedCity = City(rawValue: user.city) ?? .mykolaiv
  }
}
