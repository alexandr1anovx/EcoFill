import SwiftUI

struct RegistrationScreen: View {
  @FocusState private var inputContentType: InputContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  private var isValidForm: Bool {
    !viewModel.fullName.isEmpty
    && viewModel.email.isValidEmail
    && viewModel.password.count > 5
    && viewModel.password == viewModel.confirmedPassword
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      ScrollView {
        VStack(spacing:15) {
          inputFields
          cityPickerView.padding(.horizontal)
          signUpButton
          signInOptionView
        }
      }
    }
    .navigationTitle("Registration")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: - Subviews
  
  private var inputFields: some View {
    VStack {
      InputField(.fullName, inputData: $viewModel.fullName)
        .focused($inputContentType, equals: .fullName)
        .textInputAutocapitalization(.words)
        .submitLabel(.continue)
        .onSubmit { inputContentType = .email }
      InputField(.email, inputData: $viewModel.email)
        .focused($inputContentType, equals: .email)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { inputContentType = .password }
      InputField(.password, inputData: $viewModel.password)
        .focused($inputContentType, equals: .password)
        .submitLabel(.next)
        .onSubmit { inputContentType = .confirmedPassword }
      InputField(
        .confirmedPassword,
        inputData: $viewModel.confirmedPassword,
        validation: .passwordConfirmation(matchingPassword: viewModel.password)
      )
      .focused($inputContentType, equals: .confirmedPassword)
      .submitLabel(.done)
      .onSubmit { inputContentType = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var cityPickerView: some View {
    HStack(spacing:0) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("", selection: $viewModel.selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue.capitalized)
        }
      }.pickerStyle(.menu)
    }
  }
  
  private var signUpButton: some View {
    Button {
      Task { await viewModel.signUp() }
    } label: {
      ButtonLabel(
        title: "Sign Up",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.4 : 1)
    .alert(item: $viewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var signInOptionView: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing:6) {
        Text("Already a member?")
          .foregroundStyle(.gray)
        Text("Sign In")
          .fontWeight(.semibold)
          .underline()
      }
      .font(.footnote)
    }
  }
}
