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
  let message: Text?
  let dismissButton: Alert.Button
  
  // Custom initializer with default value for message
  init(title: Text, message: Text? = nil, dismissButton: Alert.Button) {
    self.title = title
    self.message = message
    self.dismissButton = dismissButton
  }
}

struct RegistrationAlertContext {
  
  static let userDoesNotExists = AlertItem(
    title: Text("Sign In Error"),
    message: Text("User with entered data does not exist"),
    dismissButton: .default(Text("OK"))
  )
  
  static let userExists = AlertItem(
    title: Text("Sign Up Error"),
    message: Text("User with entered data already exists"),
    dismissButton: .default(Text("OK"))
  )
}

struct ProfileAlertContext {
  
  static let successfullAccountDeletion = AlertItem(
    title: Text("Account successfully deleted"),
    dismissButton: .default(Text("OK"))
  )
  
  static let unsuccessfullAccountDeletion = AlertItem(
    title: Text("Unsuccessfull Account Deletion"),
    message: Text("Something went wrong."),
    dismissButton: .default(Text("OK"))
  )
  
  static let unsuccessfullEmailUpdate = AlertItem(
    title: Text("Unsuccessfull Email Update"),
    message: Text("This email address is already taken."),
    dismissButton: .default(Text("OK"))
  )
  
  static let confirmationLinkSent = AlertItem(
    title: Text("Confirmation Link Sent"),
    message: Text("The confirmation link has been sent to the specified email."),
    dismissButton: .default(Text("OK"))
  )
}
