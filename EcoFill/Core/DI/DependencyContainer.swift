import Foundation

class DependencyContainer {
  
  static let shared = DependencyContainer()
  
  let authService: AuthServiceProtocol
  
  // initializer for production
  private init() {
    self.authService = AuthService()
  }
  
  // initializer for testing with mock services
  init(authService: AuthServiceProtocol) {
    self.authService = authService
  }
}
