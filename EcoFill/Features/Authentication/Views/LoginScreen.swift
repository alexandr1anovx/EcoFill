import SwiftUI

struct LoginScreen: View {
  @State private var viewModel: LoginViewModel
  
  private let authService: AuthServiceProtocol // pass this for the registration screen
  private let userService: UserServiceProtocol // pass this for the registration screen
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self.authService = authService
    self.userService = userService
    self._viewModel = State(wrappedValue: LoginViewModel(authService: authService))
  }
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        HStack(spacing:0) {
          Text("Welcome to EcoFill  ")
            .fontWeight(.bold)
            .fontDesign(.rounded)
            .foregroundStyle(
              LinearGradient(
                colors: [.green, .accentColor],
                startPoint: .leading,
                endPoint: .trailing
              )
            )
          Image(systemName: "leaf.fill")
            .foregroundStyle(.green)
          Image(systemName: "fuelpump.fill")
            .foregroundStyle(.green)
        }
        .font(.title2)
        .padding(.bottom)
        
        TextFields(viewModel: viewModel)
        SignInButton(viewModel: viewModel)
        
        HStack {
          ForgotPasswordOption()
          Spacer()
          // Sign Up option
          HStack(spacing: 5) {
            Text("New user?")
              .foregroundStyle(.secondary)
            NavigationLink {
              RegistrationScreen(authService: authService, userService: userService)
            } label: {
              Text("Sign Up")
                .underline(true)
            }
          }.font(.footnote)
        }.padding(.horizontal, 20)
      }
    }
  }
}

private extension LoginScreen {
  struct TextFields: View {
    @Bindable var viewModel: LoginViewModel
    @FocusState private var inputContent: InputContent?
    var body: some View {
      VStack {
        DefaultTextField(
          title: "Email address",
          iconName: "at",
          text: $viewModel.email
        )
        .focused($inputContent, equals: .email)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .keyboardType(.emailAddress)
        .submitLabel(.next)
        .onSubmit { inputContent = .password }
        SecureTextField(
          title: "Password",
          iconName: "lock",
          text: $viewModel.password,
          showToggleIcon: false
        )
        .focused($inputContent, equals: .password)
        .submitLabel(.done)
        .onSubmit { inputContent = nil }
      }
      .padding(.horizontal, 15)
    }
  }
  struct SignInButton: View {
    @Bindable var viewModel: LoginViewModel
    var body: some View {
      Button {
        Task { await viewModel.signIn() }
      } label: {
        Text("Sign In")
          .prominentButtonStyle(tint: .green)
      }
      .padding(.horizontal,15)
      .disabled(!viewModel.isValidForm)
      .opacity(!viewModel.isValidForm ? 0.5 : 1)
    }
  }
  struct ForgotPasswordOption: View {
    var body: some View {
      NavigationLink {
        ResetPasswordScreen()
      } label: {
        Text("Forgot password?")
          .font(.caption)
          .foregroundStyle(.secondary)
          .underline(true)
      }
    }
  }
}

#Preview {
  LoginScreen(
    authService: AuthService(),
    userService: MockUserService()
  )
}
