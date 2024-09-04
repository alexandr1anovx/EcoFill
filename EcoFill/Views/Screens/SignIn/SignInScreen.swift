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
                SignInFormFields(email: $email,password: $password)
                
                BaseButton("Sign In", .entry, .cmBlue) {
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
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .fontDesign(.rounded)
                        .foregroundStyle(.gray)
                    NavigationLink("Sign Up") {
                        SignUpScreen()
                    }
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.accent)
                }
                Spacer()
            }
            .padding(15)
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            
            .alert(item: $userViewModel.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
        }
    }
}
