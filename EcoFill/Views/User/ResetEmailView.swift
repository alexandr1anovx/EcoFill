import SwiftUI
import Firebase

struct ResetEmailView: View {
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var textFieldData: TextFieldData?
    
    @State private var newEmail = ""
    @State private var password = ""
    
    private var isFormValid: Bool {
         newEmail.isValidEmail && password.count > 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                XmarkButton()
            }
            CustomTextField(
                inputData: $newEmail,
                title: "New email address",
                placeholder: "mail@example.com",
                isSecureField: false
            )
            .focused($textFieldData, equals: .email)
            .onSubmit { textFieldData = .password }
            .submitLabel(.next)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            
            CustomTextField(
                inputData: $password,
                title: "Password",
                placeholder: "Your current password",
                isSecureField: true
            )
            .focused($textFieldData, equals: .password)
            .onSubmit { textFieldData = nil }
            .submitLabel(.next)
            
            BaseButton("Confirm", .success, .cmBlue) {
                Task {
                    await userVM.updateEmail(
                        to: newEmail,
                        with: password
                    )
                }
                textFieldData = nil
            }
            .opacity(isFormValid ? 1.0 : 0.5)
            
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear { textFieldData = .email }
        .alert(item: $userVM.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton
            )
        }
    }
}
