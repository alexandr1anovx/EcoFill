import SwiftUI

struct SignUpScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var firestoreViewModel: FirestoreViewModel
    
    // MARK: - Private Properties
    @FocusState private var textField: TextFieldContent?
    @State private var initials: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var selectedCity: City = .mykolaiv
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                CustomTextField(
                    inputData: $initials,
                    title: "Initials",
                    placeholder: "Tim Cook"
                )
                .focused($textField, equals: .initials)
                .submitLabel(.next)
                .onSubmit { textField = .email }
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                
                CustomTextField(
                    inputData: $email,
                    title: "Email",
                    placeholder: "yourmail@example.com"
                )
                .focused($textField, equals: .email)
                .submitLabel(.next)
                .onSubmit { textField = .password }
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                
                CustomTextField(
                    inputData: $password,
                    title: "Password",
                    placeholder: "Must contain at least 6 characters.",
                    isSecureField: true
                )
                .focused($textField, equals: .password)
                .submitLabel(.next)
                .onSubmit { textField = .confirmPassword }
                
                CustomTextField(
                    inputData: $confirmPassword,
                    title: "Confirm password",
                    placeholder: "Must match the password.",
                    isSecureField: true
                )
                .focused($textField, equals: .confirmPassword)
                .submitLabel(.done)
                .onSubmit { textField = nil }
                
                .overlay(alignment: .trailing) {
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        let match = password == confirmPassword
                        Image(match ? .success : .xmark)
                            .defaultImageSize
                    }
                }
                
                HStack {
                    Image(.mark)
                        .defaultImageSize
                    Picker("", selection: $selectedCity) {
                        ForEach(City.allCases) { city in
                            Text(city.rawValue)
                        }
                    }
                    .tint(.cmReversed)
                }
                Spacer()
            }
            .padding(15)
            
            .alert(item: $authenticationViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign Up") {
                        Task {
                            await authenticationViewModel.createUser(
                                withCity: selectedCity.rawValue,
                                initials: initials,
                                email: email,
                                password: password
                            )
                        }
                    }
                    .disabled(!isValidForm)
                    .opacity(isValidForm ? 1.0 : 0.5)
                }
            }
        }
    }
}

// MARK: - AuthenticationForm
extension SignUpScreen: AuthenticationForm {
    var isValidForm: Bool {
        return !initials.isEmpty
        && email.isValidEmail
        && password.count > 5
        && confirmPassword == password
    }
}
