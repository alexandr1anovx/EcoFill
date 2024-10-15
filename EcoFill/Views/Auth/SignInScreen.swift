import SwiftUI

struct SignInScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    @State private var email = ""
    @State private var password = ""
    
    private var isValidForm: Bool {
        email.isValidEmail && password.count > 5
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Image("greetingView")
                    .resizable()
                    .frame(width: 280, height: 180)
                    .shadow(color: .accent, radius: 10)
                
                CustomTextField("Email", placeholder: "Enter your email address", inputData: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($fieldData, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { fieldData = .password }
                
                CustomTextField(
                    "Password",
                    placeholder: "Enter your password",
                    isSecureField: true,
                    inputData: $password
                )
                .focused($fieldData, equals: .password)
                .submitLabel(.done)
                .onSubmit { fieldData = nil }
                
                CustomBtn("Sign In", image: "person.badge.shield.checkmark", color: .accent) {
                    Task {
                        await userVM.signIn(withEmail: email, password: password)
                    }
                }
                .disabled(!isValidForm)
                .opacity(isValidForm ? 1.0 : 0.5)
                
                HStack(spacing: 5) {
                    Text("New member?")
                        .font(.poppins(.regular, size: 14))
                        .foregroundStyle(.gray)
                    
                    NavigationLink("Sign Up") {
                        SignUpScreen()
                    }
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.accent)
                }
            }
            .padding(.horizontal)
            .alert(item: $userVM.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
        }
    }
}
