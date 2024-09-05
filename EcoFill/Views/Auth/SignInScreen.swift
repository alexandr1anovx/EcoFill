import SwiftUI

struct SignInScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var formVM: FormValidationViewModel
    @FocusState private var fieldData: TextFieldData?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                CustomTextField(
                    inputData: $formVM.email,
                    title: "Email",
                    placeholder: "Your email"
                )
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .focused($fieldData, equals: .email)
                .submitLabel(.next)
                .onSubmit { fieldData = .password }
                
                CustomTextField(
                    inputData: $formVM.password,
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
                            withEmail: formVM.email,
                            password: formVM.password
                        )
                    }
                }
                .disabled(!formVM.isFormValid)
                .opacity(formVM.isFormValid ? 1.0 : 0.5)
                
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
