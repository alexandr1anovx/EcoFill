import SwiftUI

struct SignUpScreen: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var initials: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    private var isValidForm: Bool {
        !initials.isEmpty
        && email.isValidEmail
        && password.count > 5
        && confirmPassword == password
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                SignUpFormFields(
                    initials: $initials,
                    email: $email,
                    password: $password,
                    confirmPassword: $confirmPassword
                )
                CityPicker()
                Spacer()
            }
            .padding(15)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign Up") {
                        Task {
                            await userViewModel.signUp(
                                withInitials: initials,
                                email: email,
                                password: password,
                                city: userViewModel.selectedCity
                            )
                        }
                    }
                    .disabled(!isValidForm)
                    .opacity(isValidForm ? 1.0 : 0.5)
                }
            }
            .alert(item: $userViewModel.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
        }
    }
}
