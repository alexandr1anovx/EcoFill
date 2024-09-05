import SwiftUI

struct SignUpScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var formVM: FormValidationViewModel
    @FocusState private var fieldData: TextFieldData?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                CustomTextField(
                    inputData: $formVM.initials,
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
                    inputData: $formVM.email,
                    title: "Email",
                    placeholder: "email@example.com"
                )
                .focused($fieldData, equals: .email)
                .submitLabel(.next)
                .onSubmit { fieldData = .password }
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                
                CustomTextField(
                    inputData: $formVM.password,
                    title: "Password",
                    placeholder: "At least 6 characters",
                    isSecureField: true
                )
                .focused($fieldData, equals: .password)
                .submitLabel(.next)
                .onSubmit { fieldData = .confirmPassword }
                
                CustomTextField(
                    inputData: $formVM.confirmPassword,
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
                                withInitials: formVM.initials,
                                email: formVM.email,
                                password: formVM.password,
                                city: userVM.selectedCity
                            )
                        }
                    }
                    .disabled(!formVM.isSignUpFormValid)
                    .opacity(formVM.isSignUpFormValid ? 1.0 : 0.5)
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
