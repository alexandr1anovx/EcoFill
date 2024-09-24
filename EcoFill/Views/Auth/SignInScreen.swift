import SwiftUI

struct SignInScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var email = ""
    @State private var password = ""
    
    private var isFormValid: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                CustomTextField(
                    inputData: $email,
                    title: "Email",
                    placeholder: "Your email"
                )
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .focused($fieldData, equals: .email)
                .submitLabel(.next)
                .onSubmit { fieldData = .password }
                
                CustomTextField(
                    inputData: $password,
                    title: "Password",
                    placeholder: "Your password",
                    isSecureField: true
                )
                .focused($fieldData, equals: .password)
                .submitLabel(.done)
                .onSubmit { fieldData = nil }
                
                BaseButton("Sign In", .entry, .cmBlue) {
                    Task {
                        await userVM.signIn(
                            withEmail: email,
                            password: password
                        )
                    }
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1.0 : 0.5)
                
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
            
            .alert(item: $userVM.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
        }
    }
}
