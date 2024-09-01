import SwiftUI

struct SignInFormFields: View {
    
    @FocusState private var textFieldData: TextFieldData?
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        CustomTextField(
            inputData: $email,
            title: "Email",
            placeholder: "Your email"
        )
        .textInputAutocapitalization(.never)
        .keyboardType(.emailAddress)
        .focused($textFieldData, equals: .email)
        .submitLabel(.next)
        .onSubmit { textFieldData = .password }
        
        CustomTextField(
            inputData: $password,
            title: "Password",
            placeholder: "Your password",
            isSecureField: true
        )
        .focused($textFieldData, equals: .password)
        .submitLabel(.done)
        .onSubmit { textFieldData = nil }
    }
}
