import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text?
  let primaryButton: Alert.Button
  let secondaryButton: Alert.Button?
  
  init(_ title: Text,
       _ message: Text? = nil,
       primaryButton: Alert.Button,
       secondaryButton: Alert.Button? = nil) {
    self.title = title
    self.message = message
    self.primaryButton = primaryButton
    self.secondaryButton = secondaryButton
  }
}

struct RegistrationAlertContext {
  
  static let userDoesNotExists = AlertItem(
    Text("Sign In Failed"),
    Text("We couldn't find an account with that email address. Please check your email and try again."),
    primaryButton: .default(Text("OK"))
  )
  static let userExists = AlertItem(
    Text("Account Already Exists"),
    Text("An account with this email address already exists. Please sign in or use a different email address."),
    primaryButton: .default(Text("OK"))
  )
}

struct ProfileAlertContext {
  
  static let successfullAccountDeletion = AlertItem(
    Text("Account Deleted"),
    Text("Your account has been successfully deleted."),
    primaryButton: .default(Text("OK"))
  )
  static let unsuccessfullAccountDeletion = AlertItem(
    Text("Couldn't Delete Account"),
    Text("We couldn't delete your account at this time. Please try again later."),
    primaryButton: .default(Text("OK"))
  )
  static let unsuccessfullEmailUpdate = AlertItem(
    Text("Email Update Failed"),
    Text("This email address is already in use. Please choose a different email address."),
    primaryButton: .default(Text("OK"))
  )
  static let confirmationLinkSent = AlertItem(
    Text("Verification Email Sent"),
    Text("Please check your email and follow the link to verify your account."),
    primaryButton: .default(Text("OK"))
  )
  static let failedToSignOut = AlertItem(
    Text("Sign Out Failed"),
    Text("We couldn't sign you out at this time. Please try again later."),
    primaryButton: .default(Text("OK"))
  )
}

struct PasswordResetAlertContext {
  static let resetLinkSent = AlertItem(
    Text("Reset Link Sent"),
    Text("Please check your email for instructions to reset your password."),
    primaryButton: .default(Text("OK"))
  )
  
  static let resetLinkFailed = AlertItem(
    Text("Couldn't Send Reset Link"),
    Text("We couldn't send the password reset link at this time. Please try again later."),
    primaryButton: .default(Text("OK"))
  )
}
