import SwiftUI

struct RegistrationScreen: View {
  
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var confirmedPassword = ""
  @State private var selectedCity = City.mykolaiv
  @FocusState private var fieldContent: InputContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    !fullName.isEmpty
    && emailAddress.isValidEmail
    && password.count > 5
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
      InputField(for: .fullName, data: $fullName)
        .focused($fieldContent, equals: .fullName)
        .textInputAutocapitalization(.words)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .emailAddress }
      InputField(for: .emailAddress, data: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .password }
      
      InputFieldSecured(for: .password, data: $password)
        .focused($fieldContent, equals: .password)
        .submitLabel(.next)
        .onSubmit { fieldContent = .passwordConfirmation }
      
      InputFieldSecured(for: .passwordConfirmation, data: $password)
        .focused($fieldContent, equals: .passwordConfirmation)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var cityPickerView: some View {
    HStack(spacing:0) {
      Text("select_your_city")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("", selection: $selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.rawValue)
        }
      }.pickerStyle(.menu)
    }
  }
  
  private var registerButton: some View {
    Button {
      Task {
        await authViewModel.register(
          fullName: fullName,
          email: emailAddress,
          password: password,
          city: selectedCity.rawValue
        )
      }
    } label: {
      ButtonLabel(
        title: "register_title",
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
        dismissButton: alert.primaryButton
      )
    }
  }
  
  private var loginOptionView: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing:6) {
        Text("already_a_member?")
          .foregroundStyle(.gray)
        Text("login_title")
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
