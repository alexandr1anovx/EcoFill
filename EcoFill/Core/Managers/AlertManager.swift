import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text?
  let dismissButton: Alert.Button
  
  init(_ title: Text,
       _ message: Text? = nil,
       dismissButton: Alert.Button) {
    self.title = title
    self.message = message
    self.dismissButton = dismissButton
  }
}

struct AuthAlertContext {
  static let failedToLogin = AlertItem(
    Text("Login Failed"),
    Text("The email or password you entered is incorrect."),
    dismissButton: .default(Text("OK"))
  )
  static let failedToLogout = AlertItem(
      Text("Logout Failed"),
      Text("An error occurred while logging out of your account. Please contact support"),
      dismissButton: .default(Text("OK"))
  )
  static let failedToRegister = AlertItem(
    Text("Registration Failed"),
    Text("An account with the provided credentials already exists."),
    dismissButton: .default(Text("OK"))
  )
}

struct ProfileAlertContext {
  static let accountDeletedSuccessfully = AlertItem(
    Text("Account Deleted"),
    Text("Your account has been successfully deleted."),
    dismissButton: .default(Text("OK"))
  )
  static let failedToDeleteAccount = AlertItem(
    Text("Account Deletion Failed"),
    Text("An error occurred while attempting to delete your account. Please try again later."),
    dismissButton: .default(Text("OK"))
  )
  static let confirmationLinkSent = AlertItem(
    Text("Verification Email Sent"),
    Text("Сheck your email and follow the link to verify your account."),
    dismissButton: .default(Text("OK"))
  )
  static let profileUpdatedSuccessfully = AlertItem(
    Text("Profile Updated Successfully"),
    Text("Your profile has been successfully updated."),
    dismissButton: .default(Text("OK"))
  )
  static let failedToUpdateProfile = AlertItem(
    Text("Profile Update Failed"),
    Text("An error occurred while updating your account. Please try again later, or contact support."),
    dismissButton: .default(Text("OK"))
  )
}

struct PasswordResetAlertContext {
  static let resetPasswordLinkSent = AlertItem(
    Text("Reset Password Link Sent"),
    Text("Check your email for instructions to reset your password."),
    dismissButton: .default(Text("OK"))
  )
  static let failedToSendPasswordResetLink = AlertItem(
    Text("Failed to Send Password Reset Link"),
    Text("We couldn't send the password reset link at this time. Please try again later."),
    dismissButton: .default(Text("OK"))
  )
}
