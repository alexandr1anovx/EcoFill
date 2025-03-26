import Foundation
import FirebaseFirestore

protocol UserServiceProtocol {
  func fetchUser(withId userId: String) async throws -> User
  func updateUserEmail(userId: String, newEmail: String) async throws
  func updateUserCity(userId: String, city: String) async throws
  func updateUserPoints(userId: String, points: Int) async throws
}

final class UserService: UserServiceProtocol {
  private let userCollection = Firestore.firestore().collection("users")
  
  func fetchUser(withId userId: String) async throws -> User {
    let snapshot = try await userCollection.document(userId).getDocument()
    guard let user = try? snapshot.data(as: User.self) else {
      throw UserServiceError.failedToFetchUser
    }
    return user
  }
  
  func updateUserEmail(userId: String, newEmail: String) async throws {
    let document = userCollection.document(userId)
    try await document.updateData(["email": newEmail])
  }
  
  func updateUserCity(userId: String, city: String) async throws {
    let document = userCollection.document(userId)
    try await document.updateData(["city": city])
  }
  
  func updateUserPoints(userId: String, points: Int) async throws {
    let document = userCollection.document(userId)
    try await document.updateData(["points": points])
  }
}

enum UserServiceError: Error {
  case failedToFetchUser
} 
