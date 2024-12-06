import SwiftUI

struct SignUpScreen: View {
  
  @State private var initials: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @FocusState private var textFieldContent: TextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isSignUpFormValid: Bool {
    !initials.isEmpty
    && email.isValidEmail
    && password.count > 5
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 25) {
        CustomTextField(
          header: "Initials",
          placeholder: "Name and surname",
          data: $initials
        )
        .focused($textFieldContent, equals: .initials)
        .textInputAutocapitalization(.words)
        .autocorrectionDisabled(true)
        .submitLabel(.next)
        .onSubmit { textFieldContent = .email }
        
        CustomTextField(
          header: "Email",
          placeholder: "email@example.com",
          data: $email
        )
        .focused($textFieldContent, equals: .email)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .submitLabel(.next)
        .onSubmit { textFieldContent = .password }
        
        CustomTextField(
          header: "Password",
          placeholder: "At least 6 characters",
          data: $password,
          isSecure: true
        )
        .focused($textFieldContent, equals: .password)
        .submitLabel(.done)
        .onSubmit { textFieldContent = nil }
        
        CityPickerView()
        
        Spacer()
      }
      .padding(.top, 25)
      .padding(.horizontal, 20)
      .navigationTitle("Sign Up")
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ArrowBackBtn()
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
      .onAppear { textFieldContent = .initials }
    }
  }
}
