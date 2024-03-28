//
//  Alert.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 05.12.2023.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text
  let dismissButton: Alert.Button
}

struct RegistrationAlertContext {
  
  // There is no account with entered data.
  static let nonExistentUser = AlertItem(title: Text("Sign In Error"),
                                         message: Text("There is no account with entered data."),
                                         dismissButton: .default(Text("OK")))
  
  // An account with the entered data already exists.
  static let existingUser = AlertItem(title: Text("Sign Up Error"),
                                      message: Text("An account with the entered data already exists."),
                                      dismissButton: .default(Text("OK")))
}

struct ProfileAlertContext {
  
  // Account deleted successfully.
  static let accountDeleted = AlertItem(title: Text("Account deleted"),
                                        message: Text("All your data has been successfully erased."),
                                        dismissButton: .default(Text("OK")))
  
  static let emailUpdateFailed = AlertItem(title: Text("Email Update Failed"),
                                             message: Text("This email address is already taken."),
                                             dismissButton: .default(Text("OK")))
  
  static let emailVerificationSent = AlertItem(title: Text("Check Your Email"),
                                              message: Text("The confirmation link has been sent to the specified email."),
                                              dismissButton: .default(Text("OK")))
}
