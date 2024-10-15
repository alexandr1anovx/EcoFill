import SwiftUI
import Firebase

struct UpdateEmailView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var newEmail = ""
    @State private var password = ""
    
    private var isFormValid: Bool {
        newEmail.isValidEmail && password.count > 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            CustomTextField("New email address", placeholder: "mail@example.com", inputData: $newEmail)
                .focused($fieldData, equals: .email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .submitLabel(.next)
                .onSubmit { fieldData = .password }
            
            CustomTextField(
                "Password",
                placeholder: "Enter your current password",
                isSecureField: true,
                inputData: $password
            )
            .focused($fieldData, equals: .password)
            .submitLabel(.done)
            .onSubmit { fieldData = nil }
            
            CustomBtn("Confirm", image: "checkmark", color: .accent) {
                Task {
                    await userVM.updateEmail(to: newEmail, with: password)
                }
            }
            .disabled(!isFormValid)
            .opacity(isFormValid ? 1.0 : 0.5)
            
            Spacer()
        }
        .padding(20)
        .onAppear { fieldData = .email }
        .alert(item: $userVM.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton
            )
        }
    }
}
