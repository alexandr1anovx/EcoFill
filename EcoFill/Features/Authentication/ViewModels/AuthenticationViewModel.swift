//
//  AuthenticationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 20.06.2025.
//

import Foundation
import Combine

@MainActor
class AuthenticationViewModel: ObservableObject {
  
  @Published var fullName: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var selectedCity: City = .kyiv
  
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var alertItem: AlertItem?
  
  private let authenticationService: AuthenticationServiceProtocol
  private var cancellables = Set<AnyCancellable>()
  
  init(authenticationService: AuthenticationServiceProtocol) {
    self.authenticationService = authenticationService
    authenticationService.authStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading:
          self.isLoading = true
          self.errorMessage = nil
        case .signedIn, .signedOut:
          self.isLoading = false
          self.errorMessage = nil
        case .error(let error):
          self.isLoading = false
          self.errorMessage = error.localizedDescription
        }
      }
      .store(in: &cancellables)
  }
  
  func signIn() async {
    guard !email.isEmpty && !password.isEmpty else {
      errorMessage = "Please, fill in all the fields!"
      return
    }
    do {
      try await authenticationService.signIn(email: email, password: password)
    } catch {
      alertItem = AuthAlertContext.failedToLogin
      errorMessage = error.localizedDescription
    }
  }
  
  func signUp() async {
    guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty else {
      errorMessage = "Please, fill in all the fields!"
      return
    }
    do {
      try await authenticationService.signUp(fullName: fullName, email: email, password: password, city: selectedCity.rawValue)
    } catch {
      alertItem = AuthAlertContext.failedToRegister
      errorMessage = error.localizedDescription
    }
  }
  
  func signOut() {
    do {
      try authenticationService.signOut()
    } catch {
      alertItem = AuthAlertContext.failedToLogout
      errorMessage = error.localizedDescription
    }
  }
}
