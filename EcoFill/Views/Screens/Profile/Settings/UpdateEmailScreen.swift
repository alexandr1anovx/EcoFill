import SwiftUI
import Firebase

struct UpdateEmailScreen: View {
  
  @State private var newEmail = ""
  @State private var password = ""
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isValidForm: Bool {
    newEmail.isValidEmail && password.count > 5
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      
      formStack
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .onAppear { fieldContent = .emailAddress }
    }
  }
  
  // MARK: - Form Stack
  private var formStack: some View {
    VStack(alignment: .leading, spacing: 15) {
      CSTextField(
        header: "Email",
        placeholder: "New email address",
        data: $newEmail
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        header: "Password",
        placeholder: "Current password",
        data: $password
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
      
      CSButton(title: "Update", image: "userCheckmark", color: .accent) {
        Task {
          await userVM.updateCurrentEmail(to: newEmail, with: password)
        }
      }
      .disabled(!isValidForm)
      .opacity(isValidForm ? 1 : 0.5)
      .alert(item: $userVM.alertItem) { alert in
        Alert(
          title: alert.title,
          message: alert.message,
          dismissButton: alert.dismissButton
        )
      }
      Spacer()
    }
  }
}
