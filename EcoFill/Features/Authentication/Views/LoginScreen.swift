import SwiftUI

struct LoginScreen: View {
  @FocusState private var inputContentType: InputContentType?
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:20) {
          Text("Login")
            .font(.title)
            .fontWeight(.bold)
          inputFields
          signInButton
          forgotPasswordButton
          signUpOptionView
        }
      }
    }
  }
  
  // MARK: - Subviews
  
  private var inputFields: some View {
    VStack {
      InputField(.email, inputData: $viewModel.email)
        .focused($inputContentType, equals: .email)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { inputContentType = .password }
      InputField(.password, inputData: $viewModel.password)
        .focused($inputContentType, equals: .password)
        .submitLabel(.done)
        .onSubmit { inputContentType = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var signInButton: some View {
    Button {
      Task { await viewModel.signIn() }
    } label: {
      ButtonLabel(
        title: "Sign In",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(viewModel.email.isEmpty && viewModel.password.isEmpty)
    .opacity(viewModel.email.isEmpty && viewModel.password.isEmpty ? 0.4 : 1)
    .alert(item: $viewModel.alertItem) { alert in
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
  
  private var signUpOptionView: some View {
    HStack(spacing:5) {
      Text("New member?").foregroundStyle(.gray)
      NavigationLink {
        RegistrationScreen()
      } label: {
        Text("Sign Up").fontWeight(.semibold)
      }
    }.font(.footnote)
  }
}
