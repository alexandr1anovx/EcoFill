import SwiftUI

struct RegistrationScreen: View {
  @Environment(\.dismiss) var dismiss
  @State private var viewModel: RegistrationViewModel
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self._viewModel = State(
      wrappedValue: RegistrationViewModel(
        authService: authService,
        userService: userService
      )
    )
  }
  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("Registration in LexiGrow")
          .font(.title2)
          .fontWeight(.bold)
          .fontDesign(.rounded)
          .foregroundStyle(
            LinearGradient(
              colors: [.green, .accentColor],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
        TextFields(viewModel: viewModel)
        CityPicker(viewModel: viewModel)
        SignUpButton(viewModel: viewModel)
        SignInOption()
      }
      .padding(.top)
    }
  }
}

private extension RegistrationScreen {
  struct TextFields: View {
    @Bindable var viewModel: RegistrationViewModel
    @FocusState private var inputContent: InputContent?
    var body: some View {
      VStack(spacing: 10) {
        DefaultTextField(
          title: "Username",
          iconName: "person",
          text: $viewModel.fullName
        )
        .focused($inputContent, equals: .fullName)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.next)
        .onSubmit { inputContent = .email }
        DefaultTextField(
          title: "Email",
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
          showToggleIcon: true
        )
        .focused($inputContent, equals: .password)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.next)
        .onSubmit { inputContent = .confirmedPassword }
        SecureTextField(
          title: "Confirm password",
          iconName: "lock",
          text: $viewModel.confirmPassword,
          showToggleIcon: false
        )
        .focused($inputContent, equals: .confirmedPassword)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
        .onSubmit { inputContent = nil }
      }
      .padding(.horizontal, 15)
    }
  }
  struct CityPicker: View {
    @Bindable var viewModel: RegistrationViewModel
    var body: some View {
      HStack(spacing:0) {
        Text("Select your city:")
          .font(.footnote)
          .foregroundStyle(.secondary)
        Picker("", selection: $viewModel.city) {
          ForEach(City.allCases, id: \.self) { city in
            Text(city.rawValue)
          }
        }
      }.padding(.horizontal)
    }
  }
  struct SignUpButton: View {
    @Bindable var viewModel: RegistrationViewModel
    var body: some View {
      Button {
        // ⚠️ authManager.signUp() action
      } label: {
        Text("Sign Up")
          .prominentButtonStyle(tint: .green)
      }
      .padding(.horizontal)
      .disabled(!viewModel.isValidForm)
      .opacity(!viewModel.isValidForm ? 0.5 : 1)
    }
  }
  struct SignInOption: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
      HStack(spacing: 5) {
        Text("Already have an account?")
          .foregroundStyle(.secondary)
        Button {
          dismiss()
        } label: {
          Text("Sign In")
            .underline()
        }.tint(.primary)
      }
      .font(.footnote)
    }
  }
}
