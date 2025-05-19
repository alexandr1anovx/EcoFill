import FirebaseFirestore
import FirebaseAuth
import SwiftUICore

@MainActor
final class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var userCity: City = .mykolaiv
  @Published var emailStatus: EmailStatus = .unverified
  @Published var alertItem: AlertItem?
  
  // MARK: - Private Properties
  
  private let authService: AuthServiceProtocol
  private var authStateListener: AuthStateDidChangeListenerHandle?
  
  // MARK: - Init / Deinit
  
  init(authService: AuthService = AuthService()) {
    self.authService = authService
    setupAuthListener()
  }
  deinit {
    if let handle = authStateListener {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  // MARK: - Public Methods
  
  func signUp(
    fullName: String,
    email: String,
    password: String,
    city: City
  ) async {
    do {
      let user = try await authService.signUp(email: email, password: password)
      let newUser = User(
        id: user.uid,
        fullName: fullName,
        email: email,
        city: city.rawValue.capitalized,
        points: Int.random(in: 0...8)
      )
      try await authService.saveUserData(for: newUser)
      self.currentUser = newUser
    } catch {
      alertItem = RegistrationAlertContext.userExists
      print("❌ Registration failed: \(error.localizedDescription)")
    }
  }
  
  func signIn(email: String, password: String) async {
    do {
      try await authService.signIn(email: email, password: password)
    } catch {
      alertItem = RegistrationAlertContext.userDoesNotExists
    }
  }
  
  func signOut() {
    do {
      try authService.signOut()
      //self.userSession = nil
      self.currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.failedToSignOut
    }
  }
  
  func deleteUser(withPassword password: String) async {
    do {
      try await authService.deleteUser(withPassword: password)
      alertItem = ProfileAlertContext.successfullAccountDeletion
      //userSession = nil
      currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
    }
  }
  
  func updateEmail(
    toEmail email: String,
    withPassword password: String
  ) async {
    do {
      try await authService.updateEmail(toEmail: email, withPassword: password)
      alertItem = ProfileAlertContext.confirmationLinkSent
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullEmailUpdate
    }
  }
  
  func checkEmailStatus() {
    emailStatus = authService.checkEmailStatus()
  }
  
  func sendPasswordResetLink(email: String) async {
    do {
      try await authService.sendPasswordResetLink(email: email)
      alertItem = PasswordResetAlertContext.resetLinkSent
    } catch {
      alertItem = PasswordResetAlertContext.resetLinkFailed
    }
  }
  
  // MARK: - Private Methods
  
  private func setupAuthListener() {
    authStateListener = Auth.auth()
      .addStateDidChangeListener { [weak self] _, user in
        guard let self = self else { return }
        self.userSession = user
        
        if user == nil {
          self.currentUser = nil
        } else {
          Task { await self.getUserData() }
        }
      }
  }
  
  private func getUserData() async {
    guard let uid = userSession?.uid else { return }
    do {
      self.currentUser = try await authService.getUserData(for: uid)
    } catch {
      print("‼️ Failed to get user data: \(error)")
    }
  }
}

// MARK: - Email Status

enum EmailStatus {
  case verified, unverified
  
  var message: LocalizedStringKey {
    switch self {
    case .verified: "email_status_verified"
    case .unverified: "email_status_unverified"
    }
  }
  var hint: LocalizedStringKey {
    switch self {
    case .verified: ""
    case .unverified: "email_status_unverified_hint"
    }
  }
}

// MARK: - Preview Mode Extension

extension AuthViewModel {
  static var previewMode: AuthViewModel {
    let viewModel = AuthViewModel()
    viewModel.currentUser = MockData.user
    return viewModel
  }
}
