import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text?
  let dismissButton: Alert.Button
  
  init(_ title: Text, _ message: Text? = nil, dismissButton: Alert.Button) {
    self.title = title
    self.message = message
    self.dismissButton = dismissButton
  }
}

struct RegistrationAlertContext {
  
  static let userDoesNotExists = AlertItem(
    Text("Failed to Sign In"),
    Text("The user with this address does not exist."),
    dismissButton: .default(Text("OK"))
  )
  static let userExists = AlertItem(
    Text("Failed to Sign Up"),
    Text("A user with the entered data already exists."),
    dismissButton: .default(Text("OK"))
  )
}

struct ProfileAlertContext {
  
  static let successfullAccountDeletion = AlertItem(
    Text("Account Successfully Deleted"),
    dismissButton: .default(Text("OK"))
  )
  static let unsuccessfullAccountDeletion = AlertItem(
    Text("Failed to Delete Account"),
    Text("An error occurred while trying to delete an account."),
    dismissButton: .default(Text("OK"))
  )
  static let unsuccessfullEmailUpdate = AlertItem(
    Text("Failed to Update Email"),
    Text("This email address is already in use."),
    dismissButton: .default(Text("OK"))
  )
  static let confirmationLinkSent = AlertItem(
    Text("Confirmation Link Sent"),
    Text("A confirmation link has been sent to your email address."),
    dismissButton: .default(Text("OK"))
  )
  static let unableToSignOut = AlertItem(
    Text("Failed to Sign Out"),
    Text("Please, contact support for assistance"),
    dismissButton: .default(Text("OK"))
  )
}
