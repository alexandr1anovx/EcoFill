import SwiftUI
import Firebase

struct ResetEmailScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var formVM: FormValidationViewModel
    @FocusState private var textFieldData: TextFieldData?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                XmarkButton()
            }
            CustomTextField(
                inputData: $formVM.email,
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
                inputData: $formVM.password,
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
                        to: formVM.email,
                        with: formVM.password
                    )
                }
                textFieldData = nil
            }
            .opacity(formVM.isFormValid ? 1.0 : 0.5)
            
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
