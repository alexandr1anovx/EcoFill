//
//  AuthViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.12.2023.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
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
  private let db = Firestore.firestore()
  private var credential: AuthCredential?
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Fetch user
  
  func fetchUser() async {
    
    guard let uid = userSession?.uid else { return }
    guard let snapshot = try? await db.collection("users").document(uid).getDocument() else {
      return
    }
    self.currentUser = try? snapshot.data(as: User.self)
  }
  
  // MARK: - Sign In
  
  func signIn(withEmail email: String, password: String) async {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
      
    } catch {
      alertItem = RegistrationAlertContext.nonExistentUser
    }
  }
  
  // MARK: - Create User
  
  func createUser(withCity city: String, fullName: String, email: String, password: String) async {
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      
      self.userSession = result.user
      
      // Send a verification link to specified email.
      try await result.user.sendEmailVerification()
      
      let user = User(id: result.user.uid, city: city, fullName: fullName, email: email)
      
      // Add the user to the database.
      let encodedUser = try Firestore.Encoder().encode(user)
      try await db.collection("users").document(user.id).setData(encodedUser)
      
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
  
  // MARK: - Delete
  
  func deleteUser(withPassword password: String) async {
    
    guard let user = userSession else { return }
    guard let email = user.email else { return }
    
    let credential = EmailAuthProvider.credential(withEmail: email, password: password)
    
    do {
      // Reauthenticate user with provided credentials.
      try await user.reauthenticate(with: credential)
      
      // Successful reauthentication. Deleting the user.
      try await user.delete()
      
      // User deleted successfully.
      alertItem = ProfileAlertContext.accountDeleted
      userSession = nil
      currentUser = nil
      deleteUserDataFromFirestore(withUid: user.uid)
      
    } catch {
      // Handle errors.
      print("Error deleting user: \(error.localizedDescription)")
    }
  }
  
  func deleteUserDataFromFirestore(withUid uid: String) {
    db.collection("users").document(uid).delete { error in
      if let error {
        print("Error deleting user data from Firestore: \(error.localizedDescription)")
      } else {
        print("Successfully deleted data from Firestore Database.")
      }
    }
  }
  
  // MARK: - Update
  
  func updateEmail(withEmail newEmail: String, password: String) async {
    
    guard let user = userSession else { return }
    guard let currentEmail = user.email else { return }
    
    let credential = EmailAuthProvider.credential(withEmail: currentEmail, password: password)
    
    do {
      // 1. Reauthenticate the user.
      try await user.reauthenticate(with: credential)
      
      // 2. Send email verification.
      try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
      
      // 3. Show the 'emailVerificationSent' alert.
      alertItem = ProfileAlertContext.emailVerificationSent
      
      // 4. Update the firestore collection.
      try await db.collection("users").document(user.uid).updateData( ["email": newEmail] )
      
      await fetchUser()
      
    } catch {
      alertItem = ProfileAlertContext.emailUpdateFailed
    }
  }
}
