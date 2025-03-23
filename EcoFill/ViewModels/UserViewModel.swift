import Foundation
import FirebaseFirestore
import FirebaseAuth

enum UserDataTextFieldContent {
  case fullName
  case emailAddress
  case password
  case supportMessage
}

enum EmailStatus {
  case verified, unverified
  
  var message: String {
    switch self {
    case .verified: "Verified."
    case .unverified: "Unverified."
    }
  }
  var hint: String {
    switch self {
    case .verified: ""
    case .unverified: "A confirmation link has been sent to the email address."
    }
  }
}

@MainActor
final class UserViewModel: ObservableObject {
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var selectedCity: City = .mykolaiv
  @Published var emailStatus: EmailStatus = .unverified
  @Published var alertItem: AlertItem?
  
  private let userCollection = Firestore.firestore().collection("users")
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Public Methods
  
  func signUp(
    withFullName fullName: String,
    email: String,
    password: String,
    city: City
  ) async {
    do {
      let result = try await Auth.auth().createUser(
        withEmail: email, password: password
      )
      self.userSession = result.user
      try await result.user.sendEmailVerification()
      
      let user = User(id: result.user.uid, fullName: fullName, email: email, city: city.title, points: 0)
      
      let encodedUser = try Firestore.Encoder().encode(user)
      let document = userCollection.document(user.id)
      try await document.setData(encodedUser)
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userExists
    }
  }
  
  func signIn(withEmail email: String, password: String) async {
    do {
      let result = try await Auth.auth().signIn(
        withEmail: email, password: password
      )
      self.userSession = result.user
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userDoesNotExists
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
    } catch {
      alertItem = ProfileAlertContext.failedToSignOut
    }
  }
  
  func deleteUser(withPassword password: String) async {
    guard let user = userSession else { return }
    guard let userEmail = user.email else { return }
    let userCredential = EmailAuthProvider.credential(
      withEmail: userEmail, password: password
    )
    do {
      try await user.reauthenticate(with: userCredential)
      // Delete user from the collection
      let userRef = userCollection.document(user.uid)
      try await userRef.delete()
      // Delete user from authentication section
      try await user.delete()
      alertItem = ProfileAlertContext.successfullAccountDeletion
      userSession = nil
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
    }
  }
  
  func updateEmail(
    toEmail newEmail: String,
    withPassword password: String
  ) async {
    guard let user = userSession else { return }
    guard let userEmail = user.email else { return }
    let credentials = EmailAuthProvider.credential(
      withEmail: userEmail, password: password
    )
    do {
      try await user.reauthenticate(with: credentials)
      try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
      alertItem = ProfileAlertContext.confirmationLinkSent
      let document = userCollection.document(user.uid)
      try await document.updateData(["email": newEmail])
      await fetchUser()
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullEmailUpdate
    }
  }
  
  func checkEmailStatus() {
    guard let user = userSession else { return }
    emailStatus = user.isEmailVerified ? .verified : .unverified
  }
  
  func sendPasswordReset(to email: String) async {
    do {
      try await Auth.auth().sendPasswordReset(withEmail: email)
      alertItem = PasswordResetAlertContext.resetLinkSent
    } catch {
      alertItem = PasswordResetAlertContext.resetLinkFailed
    }
  }
  
  // MARK: - Private Methods
  
  private func fetchUser() async {
    guard let uid = userSession?.uid else { return }
    guard let snapshot = try? await userCollection.document(uid).getDocument() else {
      return
    }
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
