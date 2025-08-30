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
  var alertItem: AlertItem?
  private(set) var isLoading = false
  
  // MARK: - Private Properties
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  private let sessionManager: SessionManager
  
  // MARK: - Init
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol, sessionManager: SessionManager) {
    self.authService = authService
    self.userService = userService
    self.sessionManager = sessionManager
  }
  
  // MARK: - Computed Properties
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName) &&
    (email == sessionManager.currentUser?.email || ValidationService.isValid(email: email))
  }
  
  var formHasChanges: Bool {
    guard let user = sessionManager.currentUser else {
      return false
    }
    let editedFullName = fullName != user.fullName
    let editedEmail = email != user.email
    let editedCity = selectedCity.rawValue != user.city
    return editedFullName || editedEmail || editedCity
  }
  
  // MARK: - Methods
  
  func updateUser() async {
    isLoading = true
    defer { isLoading = false }
    guard var user = sessionManager.currentUser else {
      return
    }
    user.fullName = fullName
    user.email = email
    user.city = selectedCity.rawValue
    do {
      try await userService.createOrUpdateAppUser(user: user)
      sessionManager.currentUser = user
    } catch {
      alertItem = ProfileAlertContext.failedToUpdateProfile(error: error)
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
  
  func retrieveUserData() {
    guard let user = sessionManager.currentUser else { return }
    fullName = user.fullName
    email = user.email
    selectedCity = City(rawValue: user.city) ?? .mykolaiv
  }
}
