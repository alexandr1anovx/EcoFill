import Foundation
import FirebaseFirestore
import FirebaseAuth

enum UserDataTextFieldContent {
  case username
  case emailAddress
  case password
  case supportMessage
}

enum EmailStatus {
  case confirmed, notConfirmed
  
  var message: String {
    switch self {
    case .confirmed: "Confirmed."
    case .notConfirmed: "Not confirmed."
    }
  }
  
  var hint: String {
    switch self {
    case .confirmed: ""
    case .notConfirmed: "A confirmation link has been sent to your e-mail address."
    }
  }
}

@MainActor
final class UserViewModel: ObservableObject {
  
  @Published var alertItem: AlertItem?
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var selectedCity = City.mykolaiv
  @Published var emailStatus: EmailStatus = .notConfirmed
  
  private let userCollection = Firestore.firestore().collection("users")
  
  // MARK: - Initializer
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Public Methods
  func signUp(
    withInitials initials: String,
    email: String,
    password: String,
    city: City
  ) async {
    do {
      let result = try await Auth.auth().createUser(
        withEmail: email,
        password: password
      )
      self.userSession = result.user
      try await result.user.sendEmailVerification()
      
      let user = User(
        id: result.user.uid,
        city: city.title,
        email: email,
        initials: initials
      )
      let encodedUser = try Firestore.Encoder().encode(user)
      let document = userCollection.document(user.id)
      try await document.setData(encodedUser)
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userExists
    }
  }
  
  func signIn(with email: String, password: String) async {
    do {
      let result = try await Auth.auth().signIn(
        withEmail: email,
        password: password
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
      alertItem = ProfileAlertContext.unableToSignOut
    }
  }
  
  func deleteUser(with password: String) async {
    guard let user = userSession else { return }
    guard let email = user.email else { return }
    
    let credential = EmailAuthProvider.credential(
      withEmail: email,
      password: password
    )
    do {
      try await user.reauthenticate(with: credential)
      try await user.delete()
      alertItem = ProfileAlertContext.successfullAccountDeletion
      userSession = nil
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
    }
  }
  
  func updateCurrentEmail(to newEmail: String, with password: String) async {
    guard let user = userSession else { return }
    guard let currentEmail = user.email else { return }
    
    let credentials = EmailAuthProvider.credential(
      withEmail: currentEmail,
      password: password
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
  
  func checkEmailVerificationStatus() {
    guard let user = userSession else { return }
    emailStatus = user.isEmailVerified ? .confirmed : .notConfirmed
  }
  
  // MARK: - Private Methods
  private func fetchUser() async {
    guard let uid = userSession?.uid else { return }
    guard let snapshot = try? await userCollection.document(uid).getDocument() else {
      return
    }
    // decode the fetched document into a User object
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
