//
//  AuthServiceProtocol.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.03.2025.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User
  func signIn(email: String, password: String) async throws
  func signOut() throws
  
  func deleteUser(withPassword: String) async throws
  func updateEmail(toEmail: String, withPassword: String) async throws
  func checkEmailStatus() -> EmailStatus
  func sendPasswordResetLink(email: String) async throws
  func getUserData(for userID: String) async throws -> User
  func saveUserData(for user: User) async throws
}
