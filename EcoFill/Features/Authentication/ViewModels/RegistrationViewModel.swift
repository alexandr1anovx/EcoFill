//
//  RegistrationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.06.2025.
//

import Foundation

@MainActor
final class RegistrationViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var fullName: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var selectedCity: City = .kyiv
  
  @Published var alertItem: AlertItem?
  @Published var isLoading: Bool = false
  
  // MARK: - Private Properties
  
  private let firebaseAuthService: AuthServiceProtocol
  private let firestoreUserService: UserServiceProtocol
  
  // MARK: - Computed Properties
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName)
    && ValidationService.isValid(email: email)
    && password.count > 5 && password == confirmedPassword
  }
  
  // MARK: - Init
  
  init(
    firebaseAuthService: AuthServiceProtocol,
    firestoreUserService: UserServiceProtocol
  ) {
    self.firebaseAuthService = firebaseAuthService
    self.firestoreUserService = firestoreUserService
  }
  
  // MARK: - Methods
  
  func signUp() async {
    isLoading = true
    
    do {
      let user = try await firebaseAuthService.signUp(
        email: email,
        password: password
      )
      let appUser = AppUser(
        uid: user.uid,
        fullName: fullName,
        email: email,
        city: selectedCity.rawValue
      )
      try await firestoreUserService.createOrUpdateAppUser(user: appUser)
      print("✅ RegistrationViewModel: Successfully signed up!")
      isLoading = false
    } catch {
      isLoading = false
      alertItem = AuthAlertContext.failedToRegister
      print("⚠️ RegistrationViewModel: Failed to sign up! \(error.localizedDescription)")
    }
  }
}
