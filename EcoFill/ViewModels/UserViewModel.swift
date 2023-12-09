//
//  UserViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI
import Combine

/// viewModel is responsible for logic (save and write user data).
class UserViewModel: ObservableObject {
  
  @AppStorage("user") private var userData: Data?
  @Published var alertItem: AlertItem?
  @Published var user = User()
  
  var isValidForm: Bool {
    guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty && !user.phoneNumber.isEmpty else {
      alertItem = ProfileFormAlertContext.invalidForm
      return false
    }
    
    guard user.email.isValidEmail else {
      alertItem = ProfileFormAlertContext.invalidEmail
      return false
    }
    
    guard user.phoneNumber.isValidPhoneNumber else {
      alertItem = ProfileFormAlertContext.invalidPhoneFormat
      return false
    }
    return true
  }
  
  func saveChanges() {
    guard isValidForm else { return }
    do {
      let encodedData = try JSONEncoder().encode(user)
      userData = encodedData
      alertItem = ProfileFormAlertContext.successfullySavedData
    } catch {
      alertItem = ProfileFormAlertContext.couldNotSaveData
    }
  }
  
  func retrieveUser() {
    guard let userData else { return }
    do {
      user = try JSONDecoder().decode(User.self, from: userData)
    } catch {
      alertItem = ProfileFormAlertContext.couldNotSaveData
    }
  }
}
