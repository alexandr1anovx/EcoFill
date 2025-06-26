import SwiftUI

struct LoginScreen: View {
  @FocusState private var inputContentType: InputContentType?
  @StateObject var viewModel: LoginViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        ScrollView {
          VStack(spacing:20) {
            Text("Login")
              .font(.title)
              .fontWeight(.bold)
            inputFields
            signInButton
            if viewModel.isLoading {
              ProgressView()
            }
            forgotPasswordButton
            signUpOptionView
          }
          .padding(.top)
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
    .disabled(!viewModel.isValidForm)
    .opacity(!viewModel.isValidForm ? 0.4 : 1)
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
