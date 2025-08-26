//
//  ProfileViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
@Observable
final class ProfileViewModel {
  var fullName = ""
  var email = ""
  var selectedCity: City = .mykolaiv
  var accountPassword = ""
  var isLoading = false
  var isExpanded = false
  var alertItem: AlertItem?
  
  // MARK: - Private Properties
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  // MARK: - Init
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self.authService = authService
    self.userService = userService
  }
  
  // MARK: - Computed Properties
  var validForm: Bool {
    !fullName.isEmpty && !email.isEmpty
  }
  
//  var isValidForm: Bool {
//    ValidationService.isValid(fullName: fullName) &&
//    (email == sessionManager?.currentUser?.email || ValidationService.isValid(email: email))
//  }
  
//  func formHasChanges() -> Bool {
//    guard let sessionManager, let user = sessionManager.currentUser else {
//      return false
//    }
//    let editedFullName = fullName != user.fullName
//    let editedEmail = email != user.email
//    let editedCity = selectedCity.rawValue != user.city
//    return editedFullName || editedEmail || editedCity
//  }
  
  // MARK: - Methods
  
//  func updateUser() async {
//    guard var currentUser = userManager?.currentUser else {
//      return
//    }
//    isLoading = true
//    
//    currentUser.fullName = fullName
//    currentUser.email = email
//    currentUser.city = selectedCity.rawValue
//    
//    do {
//      try await userService.createOrUpdateAppUser(user: currentUser)
//      userManager?.currentUser = currentUser
//      if isExpanded {
//        isExpanded = false
//      }
//    } catch {
//      print("⚠️ ProfileViewModel: Failed to update user data: \(error.localizedDescription)")
//    }
//    isLoading = false
//  }
  
  func signOut() {
    do {
      try authService.signOut()
    } catch {
      print("Cannot sign out: \(error)")
    }
  }
  
  func deleteAccount() async {
    do {
      try await userService.deleteUserDocument(withPassword: accountPassword)
      try await authService.deleteAccount()
      alertItem = ProfileAlertContext.accountDeletedSuccessfully
    } catch {
      alertItem = ProfileAlertContext.failedToDeleteAccount(error: error)
    }
  }
}
