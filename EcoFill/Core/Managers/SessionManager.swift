//
//  SessionManager.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.06.2025.
//

import Foundation
import FirebaseAuth

enum SessionState: Equatable {
  case loggedIn(FirebaseAuth.User)
  case loggedOut
}

@Observable final class SessionManager {
  var state: SessionState = .loggedOut
  var currentUser: AppUser?
  
  private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
  
  init(userService: UserServiceProtocol, isForPreview: Bool = false) {
    if !isForPreview {
      authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
        guard let self = self else { return }
        if let firebaseUser = user {
          self.state = .loggedIn(firebaseUser)
          Task {
            do {
              self.currentUser = try await userService.fetchAppUser(uid: firebaseUser.uid)
            } catch {
              self.currentUser = nil
            }
          }
        } else {
          self.state = .loggedOut
          self.currentUser = nil
        }
      }
    }
  }
  deinit {
    if let handle = authStateListenerHandle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}

extension SessionManager {
  static let mockObject: SessionManager = {
    let mockUserService = MockUserService()
    let manager = SessionManager(userService: mockUserService, isForPreview: true)
    manager.currentUser = AppUser(
      uid: "1",
      fullName: "Name Surname",
      email: "testemail@gmail.com",
      city: "Mykolaiv"
    )
    return manager
  }()
}
