import SwiftUI
import Firebase

struct ResetEmailScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState private var textFieldData: TextFieldData?
    @State private var email: String = ""
    @State private var password: String = ""
    
    private var isValidForm: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                DismissXButton()
            }
            CustomTextField(
                inputData: $email,
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
                    await userViewModel.updateEmail(
                        to: email,
                        with: password
                    )
                }
                textFieldData = nil
            }
            .opacity(isValidForm ? 1.0 : 0.5)
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear { textFieldData = .email }
        .alert(item: $userViewModel.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton
            )
        }
    }
}
