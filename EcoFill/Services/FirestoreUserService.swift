//
//  UserService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.06.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserServiceProtocol {
  func fetchAppUser(uid: String) async throws -> AppUser?
  func createOrUpdateAppUser(user: AppUser) async throws
  func deleteUserDocument(withPassword: String) async throws
}

final class FirestoreUserService: UserServiceProtocol {
  
  private let db = Firestore.firestore()
  
  func fetchAppUser(uid: String) async throws -> AppUser? {
    let docRef = db.collection("users").document(uid)
    let document = try await docRef.getDocument()
    if document.exists {
      return try document.data(as: AppUser.self)
    } else {
      return nil
    }
  }
  
  func createOrUpdateAppUser(user: AppUser) async throws {
    guard let uid = user.id else {
      throw NSError(
        domain: "UserService",
        code: 0,
        userInfo: [NSLocalizedDescriptionKey: "User ID is nil"]
      )
    }
    try db.collection("users").document(uid).setData(from: user, merge: true)
  }
  
  func deleteUserDocument(withPassword password: String) async throws {
    guard let user = Auth.auth().currentUser, let email = user.email else {
      throw AuthErrorCode(.userNotFound)
    }
    let credential = EmailAuthProvider.credential(withEmail: email, password: password)
    try await user.reauthenticate(with: credential)
    try await db
      .collection("users")
      .document(user.uid)
      .delete()
  }
}
