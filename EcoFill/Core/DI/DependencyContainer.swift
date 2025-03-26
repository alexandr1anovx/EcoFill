import Foundation

class DependencyContainer {
  
  static let shared = DependencyContainer()
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  // initializer for production
  private init() {
    self.authService = AuthService()
    self.userService = UserService()
  }
  
  // initializer for testing with mock services
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self.authService = authService
    self.userService = userService
  }
}
