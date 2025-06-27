//
//  SessionManager.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.06.2025.
//

import Foundation
import FirebaseAuth

enum SessionState: Equatable {
  case loggedIn(User)
  case loggedOut
}

@MainActor
final class SessionManager: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var sessionState: SessionState = .loggedOut
  @Published var currentUser: AppUser? = nil
  
  // MARK: - Private Properties
  
  private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
  private let firestoreUserService: UserServiceProtocol
  
  // MARK: - Init / Deinit
  
  init(firestoreUserService: UserServiceProtocol) {
    self.firestoreUserService = firestoreUserService
    
    authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else { return }
      if let firebaseUser = user {
        self.sessionState = .loggedIn(firebaseUser)
        Task {
          do {
            self.currentUser = try await self.firestoreUserService.fetchAppUser(uid: firebaseUser.uid)
            print("✅ SessionManager: Fetched current user successfully!")
          } catch {
            print("⚠️ SessionManager: Error fetching current user: \(error.localizedDescription)")
            self.currentUser = nil
          }
        }
      } else {
        self.sessionState = .loggedOut
        self.currentUser = nil
      }
    }
  }
  
  deinit {
    if let handle = authStateListenerHandle {
      Auth.auth().removeStateDidChangeListener(handle)
      print("✅ SessionManager: Deinitialized auth state change listener!")
    }
  }
}
