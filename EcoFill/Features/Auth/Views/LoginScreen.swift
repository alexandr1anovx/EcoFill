import SwiftUI

struct LoginScreen: View {
  
  @State private var email = ""
  @State private var password = ""
  @FocusState private var fieldContent: InputContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - body
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:20) {
          Text("Login")
            .font(.title)
            .fontWeight(.bold)
          inputView
          loginButton
          forgotPasswordButton
          registerOptionView
        }
      }
    }
  }
  
  // MARK: - Subviews
  
  private var inputView: some View {
    VStack {
      InputField(.email, inputData: $email)
        .focused($fieldContent, equals: .email)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .password }
      
      InputField(.password, inputData: $password)
        .focused($fieldContent, equals: .password)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var loginButton: some View {
    Button {
      Task {
        await authViewModel.logIn(email: email, password: password)
        password = ""
      }
    } label: {
      ButtonLabel(
        title: "Login",
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
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    NavigationLink {
      ResetPasswordScreen()
    } label: {
      Text("Forgot password?")
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  private var registerOptionView: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .foregroundStyle(.gray)
      NavigationLink {
        RegistrationScreen()
      } label: {
        Text("Register")
          .fontWeight(.semibold)
      }
    }.font(.footnote)
  }
}

#Preview {
  LoginScreen()
    .environmentObject(AuthViewModel.previewMode)
}
