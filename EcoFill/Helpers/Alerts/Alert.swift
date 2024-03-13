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
  
  // Inform the user to confirm the email address.
  static let verifyEmailAddress = AlertItem(title: Text("Verify Email"),
                                            message: Text("Please, confirm your email address in the settings."),
                                            dismissButton: .default(Text("OK")))
  
  // Account was successfully deleted.
  static let accountDeleted = AlertItem(title: Text("Account was successfully deleted."),
                                                    message: Text("All your data has been erased."),
                                                    dismissButton: .default(Text("OK")))
  
  // The changes have been saved successfully.
  static let successfullySavedData  = AlertItem(title: Text("Profile Saved"),
                                                message: Text("Successfully saved your data."),
                                                dismissButton: .default(Text("OK")))
  
  // There is an error occurred while saving changes.
  static let couldNotSaveData = AlertItem(title: Text("Saving data error"),
                                          message: Text("There was an error saving or retrieving your data."),
                                          dismissButton: .default(Text("OK")))
}
