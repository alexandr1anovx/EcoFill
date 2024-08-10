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
        title: Text("Sign In Failed"),
        message: Text("The entered user does not exist."),
        dismissButton: .default(Text("OK"))
    )
    
    static let userExists = AlertItem(
        title: Text("Sign Up Failed"),
        message: Text("A user with the entered information already exists."),
        dismissButton: .default(Text("OK"))
    )
}

struct ProfileAlertContext {
    static let successfullAccountDeletion = AlertItem(
        title: Text("Account Deleted"),
        dismissButton: .default(Text("OK"))
    )
    
    static let unsuccessfullAccountDeletion = AlertItem(
        title: Text("Account Deletion Failed"),
        message: Text("An error occurred while trying to delete your account."),
        dismissButton: .default(Text("OK"))
    )
    
    static let unsuccessfullEmailUpdate = AlertItem(
        title: Text("Email Update Failed"),
        message: Text("This email address is already in use."),
        dismissButton: .default(Text("OK"))
    )
    
    static let confirmationLinkSent = AlertItem(
        title: Text("Confirmation Link Sent"),
        message: Text("A confirmation link has been sent to your email address."),
        dismissButton: .default(Text("OK"))
    )
}
