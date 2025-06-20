import SwiftUI

struct RegistrationScreen: View {
  
  @State private var fullName = ""
  @State private var email = ""
  @State private var password = ""
  @State private var confirmedPassword = ""
  @State private var selectedCity = City.mykolaiv
  @FocusState private var fieldContent: InputContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    !fullName.isEmpty
    && email.isValidEmail
    && password.count > 5
    && password == confirmedPassword
  }
  
  // MARK: - body
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      ScrollView {
        VStack(spacing:15) {
          inputView
          cityPickerView.padding(.horizontal)
          registerButton
          loginOptionView
        }
      }
    }
    .navigationTitle("Registration")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: - Subviews
  
  private var inputView: some View {
    VStack {
      InputField(.fullName, inputData: $fullName)
        .focused($fieldContent, equals: .fullName)
        .textInputAutocapitalization(.words)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .email }
      InputField(.email, inputData: $email)
        .focused($fieldContent, equals: .email)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .password }
      
      InputField(.password, inputData: $password)
        .focused($fieldContent, equals: .password)
        .submitLabel(.next)
        .onSubmit { fieldContent = .confirmedPassword }
      
      InputField(.confirmedPassword, inputData: $confirmedPassword, validation: .passwordConfirmation(matchingPassword: password))
        .focused($fieldContent, equals: .confirmedPassword)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var cityPickerView: some View {
    HStack(spacing:0) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue.capitalized)
        }
      }.pickerStyle(.menu)
    }
  }
  
  private var registerButton: some View {
    Button {
      Task {
        await authViewModel.register(
          fullName: fullName,
          email: email,
          password: password,
          city: selectedCity.rawValue
        )
      }
    } label: {
      ButtonLabel(
        title: "Register",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.4 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var loginOptionView: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing:6) {
        Text("Already a member?")
          .foregroundStyle(.gray)
        Text("Login")
          .fontWeight(.semibold)
          .underline()
      }
      .font(.footnote)
    }
  }
}

#Preview {
  RegistrationScreen()
    .environmentObject(AuthViewModel.previewMode)
}
