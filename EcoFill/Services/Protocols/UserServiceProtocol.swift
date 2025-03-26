//
//  UserServiceProtocol.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.03.2025.
//

import Foundation

protocol UserServiceProtocol {
  
  func fetchUser(withId userId: String) async throws -> User
  func updateUserEmail(userId: String, newEmail: String) async throws
  func updateUserCity(userId: String, city: String) async throws
  func updateUserPoints(userId: String, points: Int) async throws
  
}
