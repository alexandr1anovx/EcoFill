import SwiftUI

struct SignUpFormFields: View {
    
    @FocusState private var textFieldData: TextFieldData?
    @Binding var initials: String
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @State private var isPasswordVisible = false
    @State private var isEyeVisible = false
    
    var body: some View {
        CustomTextField(
            inputData: $initials,
            title: "Initials",
            placeholder: "Your name and surname"
        )
        .onAppear { textFieldData = .initials }
        .focused($textFieldData, equals: .initials)
        .submitLabel(.next)
        .onSubmit { textFieldData = .email }
        .textInputAutocapitalization(.words)
        .autocorrectionDisabled(false)
        
        CustomTextField(
            inputData: $email,
            title: "Email",
            placeholder: "email@example.com"
        )
        .focused($textFieldData, equals: .email)
        .submitLabel(.next)
        .onSubmit {
            textFieldData = .password
            isEyeVisible.toggle()
        }
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        
        CustomTextField(
            inputData: $password,
            title: "Password",
            placeholder: "Must contain at least 6 characters",
            isSecureField: isPasswordVisible
        )
        .focused($textFieldData, equals: .password)
        .submitLabel(.next)
        .onSubmit { textFieldData = .confirmPassword }
        
        .overlay(alignment: .trailing) {
            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(isPasswordVisible ? .closedEye : .openedEye)
                    .defaultImageSize
                    .opacity(isEyeVisible ? 1.0 : 0.0)
            }
        }
        
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
                if match {
                    Image(.success).defaultImageSize
                } else {
                    Image(.xmark).defaultImageSize
                }
            }
        }
    }
}
