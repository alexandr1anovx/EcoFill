//
//  AuthViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.12.2023.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

protocol AuthenticationForm {
  var isValidForm: Bool { get }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var alertItem: AlertItem?
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Fetch user
  
  func fetchUser() async {
    guard let uid = userSession?.uid else { return }
    guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
      return
    }
    self.currentUser = try? snapshot.data(as: User.self)
  }
  
  // MARK: - Sign In
  
  func signIn(withEmail email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.nonExistentUser
    }
  }
  
  // MARK: - Create User
  
  func createUser(withCity city: String, fullName: String, email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      
      // Send a verification link to specified email.
      try await result.user.sendEmailVerification()
      
      // Create a user object.
      let user = User(id: result.user.uid, fullName: fullName, email: email, city: city)
      
      // Adding user data to the database.
      let encodedUser = try Firestore.Encoder().encode(user)
      try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
      
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.existingUser
    }
  }
  
  // MARK: - Sign Out
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      // Unable to sign user out with error: \(error.localizedDescription)")
    }
  }
  
  // MARK: - Delete account
  
  func deleteUser() {
    if let user = userSession {
      user.delete { error in
        if let error {
          print("Unable to delete the user: \(error.localizedDescription)")
        } else {
          self.alertItem = ProfileAlertContext.accountDeleted
          self.userSession = nil
          self.currentUser = nil
        }
      }
    }
  }
  
  // MARK: - Update user data
  
  func updateUserEmail(oldPassword: String, newEmail: String) {
    // 1. Get the current user.
    if let user = userSession {
      // 2. Re-authenticate the user.
      let credential = EmailAuthProvider.credential(withEmail: user.email!, password: oldPassword)
      
      user.reauthenticate(with: credential) { authResult, error in
        if let error {
          print("Re-authentication failed: \(error.localizedDescription)")
        } else {
          // 3. Update the email address.
          /*
          user.updateEmail(to: newEmail) { error in
            if let error {
              print("Email update failed: \(error.localizedDescription)")
            } else {
              user.sendEmailVerification { error in
                if let error {
                  print("Error sending verification email: \(error.localizedDescription)")
                  return
                }
              }
              print("Email address updated!")
            }
          }
          */
        }
      }
    }
  }
}

