//
//  LoginViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var alertItem: AlertItem?
  @Published var isLoading: Bool = false
  
  private let firebaseAuthService: AuthServiceProtocol
  
  var isValidForm: Bool {
    !email.isEmpty && !password.isEmpty
  }
  
  init(firebaseAuthService: AuthServiceProtocol) {
    self.firebaseAuthService = firebaseAuthService
  }
  
  // MARK: - Methods
  
  func signIn() async {
    isLoading = true
    do {
      let _ = try await firebaseAuthService.signIn(
        email: email,
        password: password
      )
    } catch {
      isLoading = false
      alertItem = AuthAlertContext.failedToLogin
    }
  }
}
