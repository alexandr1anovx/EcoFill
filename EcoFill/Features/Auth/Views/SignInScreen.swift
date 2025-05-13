import SwiftUI

struct SignInScreen: View {
  
  @State private var isFormVisible = false
  @State private var email = ""
  @State private var password = ""
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    email.isValidEmail && password.count > 5
  }
  
  // MARK: - body
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing: 20) {
          Image(.logo)
            .frame(height: 90)
          if isFormVisible {
            AuthHeaderView(for: .signIn)
            textFields
            signInButton
            forgotPasswordButton
            signUpOption
          }
          Spacer()
        }
        .padding(.top)
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation(.spring(duration: 0.8)) {
            isFormVisible = true
          }
        }
      }
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $email,
        iconName: "envelope",
        hint: "input_email"
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .autocorrectionDisabled(true)
      .textInputAutocapitalization(.never)
      .submitLabel(.continue)
      .onSubmit { fieldContent = .password }
      
      SecuredTextField(
        inputData: $password,
        iconName: "lock",
        hint: "input_password"
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .customListSetup(
      height: 145,
      rowHeight: 50,
      rowSpacing: 8,
      shadow: 1,
      scrollDisabled: true
    )
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await authViewModel.signIn(email: email, password: password)
        password = ""
      }
    } label: {
      ButtonLabel(
        title: "sign_in_button",
        textColor: .primaryText,
        pouring: .buttonBackground
      )
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    NavigationLink {
      ForgotPasswordScreen()
    } label: {
      Text("forgot_password")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .underline(true)
    }
  }
  
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("new_member?").foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("sign_up_title").foregroundStyle(.primaryLabel)
      }
    }
    .font(.footnote)
    .fontWeight(.semibold)
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthViewModel.previewMode)
}
