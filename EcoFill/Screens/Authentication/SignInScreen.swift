import SwiftUI

struct SignInScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - Private Properties
    @FocusState private var textField: TextFieldContent?
    @State private var email: String = ""
    @State private var password: String = ""
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                CustomTextField(
                    inputData: $email,
                    title: "Email",
                    placeholder: "The email you specified"
                )
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .focused($textField, equals: .email)
                .submitLabel(.next)
                .onSubmit { textField = .password }
                
                CustomTextField(
                    inputData: $password,
                    title: "Password",
                    placeholder: "The password you set"
                )
                .focused($textField, equals: .password)
                .submitLabel(.done)
                .onSubmit { textField = nil }
                
                SignInButton {
                    Task {
                        await authenticationViewModel.signIn(
                            withEmail: email,
                            password: password
                        )
                    }
                }
                .disabled(!isValidForm)
                .opacity(isValidForm ? 1.0 : 0.5)
                
                HStack {
                    Text("Dont have an account?")
                        .font(.lexendFootnote).foregroundStyle(.gray)
                    NavigationLink("Sign Up") {
                        SignUpScreen()
                    }
                    .font(.lexendHeadline)
                    .foregroundStyle(.brown)
                }
                Spacer()
            }
            .padding(15)
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            
            .alert(item: $authenticationViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
        }
    }
}

// MARK: - AuthenticationForm
extension SignInScreen: AuthenticationForm {
    var isValidForm: Bool {
        return email.isValidEmail && password.count > 5
    }
}
