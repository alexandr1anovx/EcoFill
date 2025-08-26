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

final class UserService: UserServiceProtocol {
  
  private let db = Firestore.firestore()
  private let userCollection = "users"
  
  func fetchAppUser(uid: String) async throws -> AppUser? {
    let documentReference = db.collection(userCollection).document(uid)
    let document = try await documentReference.getDocument()
    if document.exists {
      return try document.data(as: AppUser.self)
    } else {
      return nil
    }
  }
  
  func createOrUpdateAppUser(user: AppUser) async throws {
    guard let uid = user.id else {
      throw AuthErrorCode(.userNotFound)
    }
    try db
      .collection(userCollection)
      .document(uid)
      .setData(from: user, merge: true)
  }
  
  func deleteUserDocument(withPassword password: String) async throws {
    guard let user = Auth.auth().currentUser,
          let email = user.email else {
      throw AuthErrorCode(.userNotFound)
    }
    let credential = EmailAuthProvider.credential(
      withEmail: email,
      password: password
    )
    try await user.reauthenticate(with: credential)
    try await db
      .collection(userCollection)
      .document(user.uid)
      .delete()
  }
}

// Наш моковый сервис
final class MockUserService: UserServiceProtocol {
    
    // Этот метод должен вернуть готового пользователя для превью.
    // UID здесь не важен, результат всегда один и тот же.
    func fetchAppUser(uid: String) async throws -> AppUser? {
        print("🤖 MockUserService: Запрос на получение пользователя...")
        
        return AppUser(
          uid: "mock_user_123",
          fullName: "Тестовий Користувач",
          email: "preview@example.com",
          city: "city.mykolaiv"
        )
    }
    
    // В превью нам не нужно реально обновлять пользователя,
    // поэтому оставляем метод пустым или добавляем print для отладки.
    func createOrUpdateAppUser(user: AppUser) async throws {
        print("🤖 MockUserService: Пользователь \(user.fullName) 'обновлен'.")
        // Ничего не делаем
    }
    
    // То же самое для удаления.
    func deleteUserDocument(withPassword: String) async throws {
        print("🤖 MockUserService: Документ пользователя 'удален'.")
        // Ничего не делаем
    }
}
