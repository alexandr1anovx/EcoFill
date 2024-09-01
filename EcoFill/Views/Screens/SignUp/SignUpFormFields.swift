import SwiftUI

struct SignUpFormFields: View {
    
    @FocusState private var textFieldData: TextFieldData?
    @Binding var initials: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var body: some View {
        CustomTextField(
            inputData: $initials,
            title: "Initials",
            placeholder: "Your name and surname"
        )
        .focused($textFieldData, equals: .initials)
        .submitLabel(.next)
        .onSubmit { textFieldData = .email }
        .textInputAutocapitalization(.words)
        .autocorrectionDisabled()
        
        CustomTextField(
            inputData: $email,
            title: "Email",
            placeholder: "mail@example.com"
        )
        .focused($textFieldData, equals: .email)
        .submitLabel(.next)
        .onSubmit { textFieldData = .password }
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        
        CustomTextField(
            inputData: $password,
            title: "Password",
            placeholder: "Must contain at least 6 characters",
            isSecureField: true
        )
        .focused($textFieldData, equals: .password)
        .submitLabel(.next)
        .onSubmit { textFieldData = .confirmPassword }
        
        CustomTextField(
            inputData: $confirmPassword,
            title: "Confirm password",
            placeholder: "Must match the password",
            isSecureField: true
        )
        .focused($textFieldData, equals: .confirmPassword)
        .submitLabel(.done)
        .onSubmit { textFieldData = nil }
        
        .overlay(alignment: .trailing) {
            if !password.isEmpty && !confirmPassword.isEmpty {
                let match = password == confirmPassword
                Image(match ? .success : .xmark)
                    .defaultImageSize
            }
        }
    }
}
