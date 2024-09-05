import Foundation

final class FormValidationViewModel: ObservableObject {
    
    @Published var initials: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var message: String = ""
    
    var isFormValid: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var isSignUpFormValid: Bool {
        !initials.isEmpty
        && email.isValidEmail
        && password.count > 5
        && confirmPassword == password
    }
    
    var isMessageCorrect: Bool {
        message.count > 10
    }
}
