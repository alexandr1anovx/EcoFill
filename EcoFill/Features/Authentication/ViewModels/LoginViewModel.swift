//
//  LoginViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
@Observable
final class LoginViewModel {
  var email = ""
  var password = ""
  private(set) var alert: AlertItem?
  private(set) var isLoading = false
  
  private let authService: AuthServiceProtocol
  
  var isValidForm: Bool {
    !email.isEmpty && !password.isEmpty
  }
  
  init(authService: AuthServiceProtocol) {
    self.authService = authService
  }
  
  func signIn() async {
    isLoading = true
    defer { isLoading = false }
    do {
      let _ = try await authService.signIn(email: email, password: password)
    } catch {
      alert = AuthAlertContext.failedToLogin
    }
  }
}
