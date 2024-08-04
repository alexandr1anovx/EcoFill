//
//  AuthViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.12.2023.
//

import Firebase
import FirebaseAuth

protocol AuthenticationForm {
  var isValidForm: Bool { get }
}

@MainActor
final class AuthenticationViewModel: ObservableObject {
  
  // MARK: - Public Properties
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var alertItem: AlertItem?
  
  // MARK: - Private Properties
  private let db = Firestore.firestore()
  
  // MARK: - Initializers
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Public Methods
  
  func signIn(withEmail email: String, and password: String) async {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userDoesNotExists
    }
  }
  
  
  
  func createUser(withCity city: String, fullName: String, email: String, password: String) async {
    do {
      let createdUser = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = createdUser.user
      try await createdUser.user.sendEmailVerification()
      
      let user = User(
        id: createdUser.user.uid,
        city: city,
        fullName: fullName,
        email: email
      )
      // Add the user to Firebase
      let encodedUser = try Firestore.Encoder().encode(user)
      try await db.collection("users").document(user.id).setData(encodedUser)
      await fetchUser()
    } catch {
      alertItem = RegistrationAlertContext.userExists
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      print("Cannot sign out, \(error.localizedDescription)")
    }
  }
  
  func deleteUser(withPassword password: String) async {
    guard let user = userSession else { return }
    guard let email = user.email else { return }
    
    let credential = EmailAuthProvider.credential(withEmail: email, password: password)
    
    do {
      try await user.reauthenticate(with: credential)
      try await user.delete()
      
      alertItem = ProfileAlertContext.successfullAccountDeletion
      userSession = nil
      currentUser = nil
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullAccountDeletion
    }
  }
  
  func updateEmail(withEmail newEmail: String, password: String) async {
    guard let user = userSession else { return }
    guard let currentEmail = user.email else { return }
    
    let credentials = EmailAuthProvider.credential(
      withEmail: currentEmail,
      password: password
    )
    do {
      try await user.reauthenticate(with: credentials)
      try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
      alertItem = ProfileAlertContext.confirmationLinkSent
      try await db.collection("users").document(user.uid).updateData(["email": newEmail])
      await fetchUser()
    } catch {
      alertItem = ProfileAlertContext.unsuccessfullEmailUpdate
    }
  }
  
  // MARK: - Private Methods
  private func fetchUser() async {
    guard let uid = userSession?.uid else { return }
    guard let snapshot = try? await db.collection("users").document(uid).getDocument() else {
      return
    }
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
