//
//  ProfileViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation
import SwiftUICore

@MainActor
final class ProfileViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var fullName: String = ""
  @Published var email: String = ""
  @Published var selectedCity: City = .mykolaiv
  @Published var accountPassword: String = ""
  
  @Published var isLoading: Bool = false
  @Published var isExpanded: Bool = false
  
  @Published var alertItem: AlertItem?
  
  @Published var isShownAccountDeletionAlert: Bool = false
  @Published var isShownSavedChangesAlert: Bool = false
  
  // MARK: - Private Properties
  
  private weak var sessionManager: SessionManager?
  private let firebaseAuthService: AuthServiceProtocol
  private let firestoreUserService: UserServiceProtocol
  
  // MARK: - Init
  
  init(
    firebaseAuthService: AuthServiceProtocol,
    firestoreUserService: UserServiceProtocol,
    sessionManager: SessionManager
  ) {
    self.firebaseAuthService = firebaseAuthService
    self.firestoreUserService = firestoreUserService
    self.sessionManager = sessionManager
  }
  
  // MARK: - Computed Properties
  
  var isFormHasChanges: Bool {
    guard let currentUser = sessionManager?.currentUser else { return false }
    let changedFullName = fullName != currentUser.fullName
    let changedEmail = email != currentUser.email
    let changedCity = selectedCity.rawValue != currentUser.city
    
    return changedFullName || changedEmail || changedCity
  }
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName) &&
    (email == sessionManager?.currentUser?.email || ValidationService.isValid(email: email))
  }
  
  // MARK: - Methods
  
  func updateUser() async {
    guard var currentUser = sessionManager?.currentUser else {
      print("⚠️ ProfileViewModel: Failed to get current user!")
      return
    }
    
    isLoading = true
    
    currentUser.fullName = fullName
    currentUser.email = email
    currentUser.city = selectedCity.rawValue
    
    do {
      try await firestoreUserService.createOrUpdateAppUser(user: currentUser)
      sessionManager?.currentUser = currentUser
      if isExpanded {
        withAnimation { isExpanded = false }
      }
      print("✅ ProfileViewModel: Profile has been updated!")
    } catch {
      print("⚠️ ProfileViewModel: Failed to update user data: \(error.localizedDescription)")
    }
    isLoading = false
  }
  
  func signOut() {
    do {
      try firebaseAuthService.signOut()
      print("✅ ProfileViewModel: Signed Out!")
    } catch {
      print("⚠️ ProfileViewModel: Failed to sign out: \(error.localizedDescription)")
    }
  }
  
  func deleteAccount() async {
    do {
      try await firestoreUserService.deleteUserDocument(withPassword: accountPassword)
      try await firebaseAuthService.deleteAccount()
      alertItem = ProfileAlertContext.accountDeletedSuccessfully
      print("✅ ProfileViewModel: Account deleted!")
    } catch {
      alertItem = ProfileAlertContext.failedToDeleteAccount(error: error)
      print("⚠️ ProfileViewModel: Failed to delete account: \(error.localizedDescription)")
    }
  }
}
