//
//  LoginViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var alertItem: AlertItem?
  @Published var isLoading: Bool = false
  
  // MARK: - Private Properties
  
  private let authService: AuthServiceProtocol
  
  // MARK: - Computed Properties
  
  var isValidForm: Bool { !email.isEmpty && !password.isEmpty }
  
  // MARK: - Init
  
  init(authService: AuthServiceProtocol) {
    self.authService = authService
  }
  
  // MARK: - Methods
  
  func signIn() async {
    isLoading = true
    do {
      let _ = try await authService.signIn(email: email, password: password)
    } catch {
      isLoading = false
      alertItem = AuthAlertContext.failedToLogin
    }
  }
}
