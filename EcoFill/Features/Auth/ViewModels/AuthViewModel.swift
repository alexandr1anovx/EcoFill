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
final class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var userCity: City = .mykolaiv
  @Published var emailStatus: EmailStatus = .unverified
  @Published var alertItem: AlertItem?
  
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  init(container: DependencyContainer = .shared) {
    self.authService = container.authService
    self.userService = container.userService
    self.userSession = authService.userSession
    
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
      try await authService.signUp(withFullName: fullName, email: email, password: password, city: city.title)
      self.userSession = authService.userSession
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userExists
    }
  }
  
  func signIn(withEmail email: String, password: String) async {
    do {
      try await authService.signIn(withEmail: email, password: password)
      self.userSession = authService.userSession
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userDoesNotExists
    }
  }
  
  func signOut() {
    do {
      try authService.signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.failedToSignOut
    }
  }
  
  func deleteUser(withPassword password: String) async {
    do {
      try await authService.deleteUser(withPassword: password)
      alertItem = ProfileAlertContext.successfullAccountDeletion
      userSession = nil
      currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
    }
  }
  
  func updateEmail(
    toEmail newEmail: String,
    withPassword password: String
  ) async {
    do {
      try await authService.updateEmail(toEmail: newEmail, withPassword: password)
      alertItem = ProfileAlertContext.confirmationLinkSent
      await fetchUser()
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullEmailUpdate
    }
  }
  
  func checkEmailStatus() {
    emailStatus = authService.checkEmailStatus()
  }
  
  func sendPasswordReset(to email: String) async {
    do {
      try await authService.sendPasswordReset(to: email)
      alertItem = PasswordResetAlertContext.resetLinkSent
    } catch {
      alertItem = PasswordResetAlertContext.resetLinkFailed
    }
  }
  
  // MARK: - Private Methods
  
  private func fetchUser() async {
    guard let uid = userSession?.uid else { return }
    do {
      self.currentUser = try await userService.fetchUser(withId: uid)
    } catch {
      // Handle error
    }
  }
}

