//
//  AuthenticationService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 20.06.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Combine

enum AuthenticationState {
  case signedIn(FirebaseAuth.User)
  case signedOut
  case loading
  case error(Error)
}

protocol AuthenticationServiceProtocol {
  var authState: AuthenticationState { get }
  var authStatePublisher: AnyPublisher<AuthenticationState, Never> { get }
  
  func signIn(email: String, password: String) async throws
  func signUp(fullName: String, email: String, password: String, city: String) async throws
  func signOut() throws
}

class AuthenticationService: ObservableObject, AuthenticationServiceProtocol {
  @Published var authState: AuthenticationState = .signedOut
  var authStatePublisher: AnyPublisher<AuthenticationState, Never> {
    $authState.eraseToAnyPublisher()
  }
  
  private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
  
  init() {
    authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
      guard let self = self else { return }
      if let firebaseUser = user {
        authState = .signedIn(firebaseUser)
      } else {
        authState = .signedOut
      }
    }
  }
  
  deinit {
    if let handle = authStateDidChangeListenerHandle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  @MainActor
  func signIn(email: String, password: String) async throws {
    authState = .loading
    do {
      let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
      authState = .signedIn(authResult.user)
    } catch {
      authState = .error(error)
      throw error
    }
  }
  
  @MainActor
  func signUp(fullName: String, email: String, password: String, city: String) async throws {
    authState = .loading
    do {
      let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
      let user = authResult.user
      
      let db = Firestore.firestore()
      try await db.collection("users").document(user.uid).setData([
        "uid": user.uid,
        "email": email,
        "fullName": fullName,
        "city": city,
      ])
      authState = .signedIn(user)
    } catch {
      authState = .error(error)
      throw error
    }
  }
  
  func signOut() throws {
    do {
      try Auth.auth().signOut()
      authState = .signedOut
    } catch {
      authState = .error(error)
      throw error
    }
  }
}
