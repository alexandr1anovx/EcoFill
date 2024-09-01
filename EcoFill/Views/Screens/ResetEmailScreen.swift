import SwiftUI
import Firebase

struct ResetEmailScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var newEmailAddress: String = ""
    @State private var currentPassword: String = ""
    @FocusState private var textFieldData: TextFieldData?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                CustomTextField(
                    inputData: $newEmailAddress,
                    title: "New email",
                    placeholder: "emailname@example.com",
                    isSecureField: false
                )
                .focused($textFieldData, equals: .email)
                .onSubmit { textFieldData = .password }
                .submitLabel(.next)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                
                CustomTextField(
                    inputData: $currentPassword,
                    title: "Current password",
                    placeholder: "Repeat your current password",
                    isSecureField: true
                )
                .focused($textFieldData, equals: .password)
                .onSubmit { textFieldData = nil }
                .submitLabel(.next)
                
                BaseButton(image: .success, title: "Confirm", pouring: .cmBlue) {
                    Task {
                        await userViewModel.updateEmail(
                            to: newEmailAddress,
                            withPassword: currentPassword
                        )
                    }
                    textFieldData = nil
                }
                .opacity(isValidForm ? 1.0 : 0.0)
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 30)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissXButton()
                        .foregroundStyle(.red)
                }
            }
            .onAppear { textFieldData = .initials }
            .alert(item: $userViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
        }
    }
}

// MARK: - Registration Form
extension ResetEmailScreen: RegistrationForm {
    var isValidForm: Bool {
        newEmailAddress.isValidEmail && currentPassword.count > 5
    }
}
