//
//  AuthManager.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.08.2025.
//

//import Foundation
//
//enum AuthState {
//  case authenticated
//  case notAuthenticated
//}
//
//@Observable class AuthManager {
//  var currentUser: AppUser?
//  var alert: AlertItem?
//  var isLoading = false
//  
//  let authService: AuthServiceProtocol
//  init(authService: AuthServiceProtocol = AuthService()) {
//    self.authService = authService
//  }
//  
//  func signIn(email: String, password: String) async {
//    isLoading = true
//    defer { isLoading = false }
//    Task {
//      do {
//        let user = try await authService.signIn(email: email, password: password)
//        self.currentUser = user
//      } catch {
//        alert = AuthAlertContext.failedToLogin
//      }
//    }
//  }
//  
//  func deleteAccount() async {
//    do {
//      //try await userService.deleteUserDocument(withPassword: accountPassword)
//      try await authService.deleteAccount()
//      alert = ProfileAlertContext.accountDeletedSuccessfully
//    } catch {
//      alert = ProfileAlertContext.failedToDeleteAccount(error: error)
//    }
//  }
//  
//}
