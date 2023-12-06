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

struct ProfileFormAlertContext {
  /// Notify the user that the form is incorrectly filled.
  static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                     message: Text("Make sure you have filled in all fields correctly."),
                                     dismissButton: .default(Text("OK")))
  /// Notify the user that the email is incorrect.
  static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                      message: Text("Make sure you have entered the correct email.\n example@gmail.com"),
                                      dismissButton: .default(Text("OK")))
  /// Notify the user that the phone number is incorrect.
  static let invalidPhoneFormat = AlertItem(title: Text("Invalid Phone Number"),
                                            message: Text("Make sure you have entered the correct phone number."),
                                            dismissButton: .default(Text("OK")))
  /// Notify user that changes have been saved successfully.
  static let successfullySavedData  = AlertItem(title: Text("Profile Saved"),
                                                message: Text("Successfully saved your data."),
                                                dismissButton: .default(Text("OK")))
  /// Notify user that an error occurred while saving changes.
  static let couldNotSaveData = AlertItem(title: Text("Profile Error"),
                                          message: Text("There was an error saving or retrieving your data."),
                                          dismissButton: .default(Text("OK")))
}
