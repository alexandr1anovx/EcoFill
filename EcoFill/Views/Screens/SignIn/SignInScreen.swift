import SwiftUI



struct SignInScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    private var isValidForm: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                SignInFormFields(email: $email, password: $password)
                    
                BaseButton(image: .success, title: "Sign In", pouring: .cmBlue) {
                    Task {
                        await userViewModel.signIn(
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
//extension SignInScreen: RegistrationForm {
//    var isValidForm: Bool {
//        email.isValidEmail && password.count > 5
//    }
//}
