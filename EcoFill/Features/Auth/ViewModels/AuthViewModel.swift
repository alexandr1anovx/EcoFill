import FirebaseFirestore
import FirebaseAuth
import SwiftUICore

@MainActor
final class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var emailStatus: EmailStatus = .unverified
  @Published var alertItem: AlertItem?
  
  // MARK: - Private Properties
  
  private let authService: AuthServiceProtocol
  private let validationService: ValidationService
  private var authStateListener: AuthStateDidChangeListenerHandle?
  
  // MARK: - Init / Deinit
  
  init(
    authService: AuthService = AuthService(),
    validationService: ValidationService = ValidationService()
  ) {
    self.authService = authService
    self.validationService = validationService
    setupAuthListener()
  }
  deinit {
    if let handle = authStateListener {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  // MARK: - Public Methods
  
  func register(
    fullName: String,
    email: String,
    password: String,
    city: String
  ) async {
    do {
      let user = try await authService.signUp(email: email, password: password)
      let newUser = User(
        id: user.uid,
        fullName: fullName,
        email: email,
        city: city
      )
      try await authService.saveUserData(for: newUser)
      self.currentUser = newUser
    } catch {
      alertItem = AuthAlertContext.failedToRegister
    }
  }
  
  func logIn(email: String, password: String) async {
    do {
      try await authService.signIn(email: email, password: password)
    } catch {
      alertItem = AuthAlertContext.failedToLogin
    }
  }
  
  func signOut() {
    do {
      try authService.signOut()
      self.currentUser = nil
    } catch {
      alertItem = AuthAlertContext.failedToLogout
    }
  }
  
  func deleteUser(withPassword password: String) async {
    do {
      try await authService.deleteUser(withPassword: password)
      alertItem = ProfileAlertContext.accountDeletedSuccessfully
      currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.failedToDeleteAccount
    }
  }
  
  func updateProfile(fullName: String, email: String, city: String) async {
    guard let currentUser = currentUser else {
      alertItem = ProfileAlertContext.failedToUpdateProfile
      return
    }
    let updatedUser = User(
      id: currentUser.id,
      fullName: fullName,
      email: email,
      city: city
    )
    do {
      try await authService.saveUserData(for: updatedUser)
      self.currentUser = updatedUser
      alertItem = ProfileAlertContext.profileUpdatedSuccessfully
    } catch {
      alertItem = ProfileAlertContext.failedToUpdateProfile
    }
  }
  
  func checkEmailStatus() {
    emailStatus = authService.checkEmailStatus()
  }
  
  func sendPasswordResetLink(email: String) async {
    do {
      try await authService.sendPasswordResetLink(email: email)
      alertItem = PasswordResetAlertContext.resetPasswordLinkSent
    } catch {
      alertItem = PasswordResetAlertContext.failedToSendPasswordResetLink
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
  
  var title: String {
    switch self {
    case .verified: "Verified"
    case .unverified: "Unverified"
    }
  }
  var message: String {
    switch self {
    case .verified: ""
    case .unverified: "A confirmation link has been sent to your email address"
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
