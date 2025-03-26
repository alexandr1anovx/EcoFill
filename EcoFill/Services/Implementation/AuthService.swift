import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthError: Error {
  case userNotFound
  case emailNotFound
  case reauthenticationFailed
}

final class AuthService: AuthServiceProtocol {
  
  var userSession: FirebaseAuth.User? {
    Auth.auth().currentUser
  }
  
  private let userCollection = Firestore.firestore().collection("users")
  
  func signUp(
    withFullName fullName: String,
    email: String,
    password: String,
    city: String
  ) async throws {
    let result = try await Auth.auth().createUser(
      withEmail: email, password: password
    )
    try await result.user.sendEmailVerification()
    
    let user = User(id: result.user.uid, fullName: fullName, email: email, city: city, points: 0)
    
    let encodedUser = try Firestore.Encoder().encode(user)
    let document = userCollection.document(user.id)
    try await document.setData(encodedUser)
  }
  
  func signIn(withEmail email: String, password: String) async throws {
    try await Auth.auth().signIn(
      withEmail: email, password: password
    )
  }
  
  func signOut() throws {
    try Auth.auth().signOut()
  }
  
  func deleteUser(withPassword password: String) async throws {
    guard let user = userSession else { throw AuthError.userNotFound }
    guard let userEmail = user.email else { throw AuthError.emailNotFound }
    
    let userCredential = EmailAuthProvider.credential(
      withEmail: userEmail, password: password
    )
    try await user.reauthenticate(with: userCredential)
    
    // Delete user from the collection
    let userRef = userCollection.document(user.uid)
    try await userRef.delete()
    
    // Delete user from authentication section
    try await user.delete()
  }
  
  func updateEmail(
    toEmail newEmail: String,
    withPassword password: String
  ) async throws {
    guard let user = userSession else { throw AuthError.userNotFound }
    guard let userEmail = user.email else { throw AuthError.emailNotFound }
    
    let credentials = EmailAuthProvider.credential(
      withEmail: userEmail, password: password
    )
    try await user.reauthenticate(with: credentials)
    try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
    
    let document = userCollection.document(user.uid)
    try await document.updateData(["email": newEmail])
  }
  
  func checkEmailStatus() -> EmailStatus {
    guard let user = userSession else { return .unverified }
    return user.isEmailVerified ? .verified : .unverified
  }
  
  func sendPasswordReset(to email: String) async throws {
    try await Auth.auth().sendPasswordReset(withEmail: email)
  }
}
