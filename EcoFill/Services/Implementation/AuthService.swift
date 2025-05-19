import FirebaseAuth
import FirebaseFirestore

enum AuthError: Error {
  case userNotFound
  case emailNotFound
  case reauthenticationFailed
}

final class AuthService: AuthServiceProtocol {
  
  // MARK: - Private Properties
  
  private let database = Firestore.firestore()
  
  // MARK: - Public Methods
  
  func signIn(email: String, password: String) async throws {
    try await Auth.auth().signIn(withEmail: email, password: password)
  }
  
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User {
    let authResult = try await Auth.auth().createUser(
      withEmail: email, password: password
    )
    return authResult.user
  }
  
  func signOut() throws {
    try Auth.auth().signOut()
  }
  
  func saveUserData(for user: User) async throws {
    let encodedUser = try Firestore.Encoder().encode(user)
    let userDocument = database
      .collection("users")
      .document(user.id)
    try await userDocument.setData(encodedUser)
  }
  
  func deleteUser(withPassword: String) async throws {
    guard let user = Auth.auth().currentUser,
            let email = user.email else {
      throw AuthErrorCode(.userNotFound)
    }
    let credential = EmailAuthProvider.credential(
      withEmail: email, password: withPassword
    )
    try await user.reauthenticate(with: credential)
    
    try await database
      .collection("users")
      .document(user.uid)
      .delete() // deletes a user from the collection
    try await user.delete() // deletes a user from the authentication section
  }
  
  func updateEmail(
    toEmail email: String,
    withPassword password: String
  ) async throws {
    guard let user = Auth.auth().currentUser else { throw AuthError.userNotFound }
    guard let userEmail = user.email else { throw AuthError.emailNotFound }
    
    let credentials = EmailAuthProvider.credential(
      withEmail: userEmail, password: password
    )
    try await user.reauthenticate(with: credentials)
    try await user.sendEmailVerification(beforeUpdatingEmail: email)
    
    try await database
      .collection("users")
      .document(user.uid)
      .updateData(["email": email])
  }
  
  func checkEmailStatus() -> EmailStatus {
    guard let user = Auth.auth().currentUser else { return .unverified }
    return user.isEmailVerified ? .verified : .unverified
  }
  
  func sendPasswordResetLink(email: String) async throws {
    try await Auth.auth().sendPasswordReset(withEmail: email)
  }
  
  func getUserData(for userID: String) async throws -> User {
    let snapshot = try await database
      .collection("users")
      .document(userID)
      .getDocument()
    
    guard let user = try? snapshot.data(as: User.self) else {
      throw AuthErrorCode(.invalidEmail)
    }
    return user
  }
}
