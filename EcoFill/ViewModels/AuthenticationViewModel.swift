//
//  AuthViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.12.2023.
//

import Foundation
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
  
  @Published var alertItem: AlertItem = ProfileFormAlertContext.couldNotSaveData
  @Published var errorMessage: String = ""
  @Published var isPresentedErrorAlert: Bool = false
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Sign In
  func signIn(withEmail email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      errorMessage = error.localizedDescription
      isPresentedErrorAlert = true
    }
  }
  
  // MARK: - Create User
  func createUser(withCity city: String, fullName: String, email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      let user = User(id: result.user.uid, fullName: fullName, email: email, city: city)
      let encodedUser = try Firestore.Encoder().encode(user)
      try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
      await fetchUser()
    } catch {
//      errorMessage = ProfileFormAlertContext.couldNotSaveData
      alertItem = ProfileFormAlertContext.invalidForm
      isPresentedErrorAlert = true
    }
  }
  
  // MARK: - Sign Out
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      print("Unable to sign user out with error: \(error.localizedDescription)")
    }
  }
  
  // MARK: - Delete account
  func deleteAccount() {
    if let user = Auth.auth().currentUser {
      user.delete { error in
        if let error = error {
          print(error.localizedDescription)
        } else {
          self.userSession = nil
          self.currentUser = nil
        }
      }
    }
  }
  
  // MARK: - Fetch user
  func fetchUser() async {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
