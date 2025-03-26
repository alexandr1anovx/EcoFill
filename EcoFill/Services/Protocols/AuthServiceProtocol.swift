//
//  AuthServiceProtocol.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.03.2025.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
  
  var userSession: FirebaseAuth.User? { get }
  func signUp(withFullName: String, email: String, password: String, city: String) async throws
  func signIn(withEmail: String, password: String) async throws
  func signOut() throws
  func deleteUser(withPassword: String) async throws
  func updateEmail(toEmail: String, withPassword: String) async throws
  func checkEmailStatus() -> EmailStatus
  func sendPasswordReset(to: String) async throws
  
}
