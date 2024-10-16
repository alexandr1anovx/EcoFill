import SwiftUI
import Firebase

struct UpdateEmailView: View {
    
    @State private var newEmail: String = ""
    @State private var password: String = ""
    @FocusState private var textFieldContent: TextFieldContent?
    @EnvironmentObject var userVM: UserViewModel
    
    private var isFormValid: Bool {
        newEmail.isValidEmail && password.count > 5
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                CustomTF(
                    header: "Email",
                    placeholder: "New email address",
                    data: $newEmail
                )
                .focused($textFieldContent, equals: .email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .submitLabel(.next)
                .onSubmit { textFieldContent = .password }
                
                CustomTF(
                    header: "Password",
                    placeholder: "Enter current password",
                    data: $password
                )
                .focused($textFieldContent, equals: .password)
                .submitLabel(.done)
                .onSubmit { textFieldContent = nil }
                
                Btn(title: "Update",
                    image: "userCheckmark",
                    color: .accent) {
                    Task {
                        await userVM.updateEmail(to: newEmail, with: password)
                    }
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1.0 : 0.5)
                
                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            .alert(item: $userVM.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton
                )
            }
            .onAppear { textFieldContent = .email }
        }
    }
}
