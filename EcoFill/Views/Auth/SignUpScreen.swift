import SwiftUI

struct SignUpScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var fieldData: TextFieldData?
    
    @State private var initials = ""
    @State private var email = ""
    @State private var password = ""
    
    private var isSignUpFormValid: Bool {
        !initials.isEmpty
        && email.isValidEmail
        && password.count > 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomTextField(
                "Initials",
                placeholder: "Name and surname",
                inputData: $initials
            )
            .focused($fieldData, equals: .initials)
            .textInputAutocapitalization(.words)
            .autocorrectionDisabled(false)
            .submitLabel(.next)
            .onSubmit { fieldData = .email }
            
            CustomTextField(
                "Email",
                placeholder: "email@example.com",
                inputData: $email
            )
            .focused($fieldData, equals: .email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .submitLabel(.next)
            .onSubmit { fieldData = .password }
            
            CustomTextField(
                "Password",
                placeholder: "At least 6 characters",
                isSecureField: true,
                inputData: $password
            )
            .focused($fieldData, equals: .password)
            .submitLabel(.done)
            .onSubmit { fieldData = nil }
            
            CityPickerView()
            
            Spacer()
        }
        .padding(.top, 25)
        .padding(.horizontal, 20)
        .navigationTitle("Sign Up")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBtn()
            }
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
                .foregroundStyle(.accent)
                .disabled(!isSignUpFormValid)
                .opacity(isSignUpFormValid ? 1.0 : 0.5)
            }
        }
        .alert(item: $userVM.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
        .onAppear { fieldData = .initials }
    }
}
