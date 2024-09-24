import SwiftUI

struct SignUpScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    
    @State private var initials = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    private var isSignUpFormValid: Bool {
        !initials.isEmpty
        && email.isValidEmail
        && password.count > 5
        && confirmPassword == password
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                CustomTextField(
                    inputData: $initials,
                    title: "Initials",
                    placeholder: "Your name and surname"
                )
                .onAppear { fieldData = .initials }
                .focused($fieldData, equals: .initials)
                .submitLabel(.next)
                .onSubmit { fieldData = .email }
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled(false)
                
                CustomTextField(
                    inputData: $email,
                    title: "Email",
                    placeholder: "email@example.com"
                )
                .focused($fieldData, equals: .email)
                .submitLabel(.next)
                .onSubmit { fieldData = .password }
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                
                CustomTextField(
                    inputData: $password,
                    title: "Password",
                    placeholder: "At least 6 characters",
                    isSecureField: true
                )
                .focused($fieldData, equals: .password)
                .submitLabel(.next)
                .onSubmit { fieldData = .confirmPassword }
                
                CustomTextField(
                    inputData: $confirmPassword,
                    title: "Confirm password",
                    placeholder: "Must match the password",
                    isSecureField: true
                )
                .focused($fieldData, equals: .confirmPassword)
                .submitLabel(.done)
                .onSubmit { fieldData = nil }
                
                CityPickerView()
                Spacer()
            }
            .padding(15)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign Up") {
                        Task {
                            await userVM.signUp(
                                withInitials: initials,
                                email: email,
                                password: password,
                                city: userVM.selectedCity
                            )
                        }
                    }
                    .disabled(!isSignUpFormValid)
                    .opacity(isSignUpFormValid ? 1.0 : 0.5)
                }
            }
            .alert(item: $userVM.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
        }
    }
}
