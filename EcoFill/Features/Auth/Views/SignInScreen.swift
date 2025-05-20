import SwiftUI

struct SignInScreen: View {
  
  @State private var email = ""
  @State private var password = ""
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - body
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:20) {
          inputView.padding(.top)
          signInButton
          HStack {
            forgotPasswordButton
            Spacer()
            registerOptionView
          }.padding(.horizontal,20)
          Spacer()
        }
      }
      .navigationTitle("Login")
      .navigationBarTitleDisplayMode(.large)
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var inputView: some View {
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
    .customListStyle(
      rowHeight: 50,
      rowSpacing: 10,
      scrollDisabled: true,
      height: 150,
      shadow: 1
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
        title: "login_button",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(email.isEmpty && password.isEmpty)
    .opacity(email.isEmpty && password.isEmpty ? 0.4 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.primaryButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    NavigationLink {
      ForgotPasswordScreen()
    } label: {
      Text("forgot_password")
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  private var registerOptionView: some View {
    HStack(spacing: 5) {
      Text("new_member?").foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("register_title").fontWeight(.semibold)
      }
    }
    .font(.footnote)
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthViewModel.previewMode)
}
