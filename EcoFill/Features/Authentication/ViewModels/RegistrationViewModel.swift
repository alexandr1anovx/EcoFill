//
//  RegistrationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
@Observable
final class RegistrationViewModel {
  var fullName = ""
  var email = ""
  var password = ""
  var confirmPassword = ""
  var city: City = .kyiv
  private(set) var alert: AlertItem?
  private(set) var isLoading = false
  
  // MARK: - Computed properties
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName)
    && ValidationService.isValid(email: email)
    && password.count > 5 && password == confirmPassword
  }
  
  // MARK: - Dependencies
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  // MARK: - Init
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self.authService = authService
    self.userService = userService
  }
  
  // MARK: - Methods
  func signUp() async {
    isLoading = true
    defer { isLoading = false }
    do {
      let user = try await authService.signUp(email: email, password: password)
      let appUser = AppUser(uid: user.uid, fullName: fullName, email: email, city: city.rawValue)
      try await userService.createOrUpdateAppUser(user: appUser)
    } catch {
      alert = AuthAlertContext.failedToRegister
    }
  }
}
