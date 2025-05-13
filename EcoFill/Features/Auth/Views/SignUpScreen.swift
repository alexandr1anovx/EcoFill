import SwiftUI

struct SignUpScreen: View {
  
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var selectedCity = City.mykolaiv
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  private var isValidForm: Bool {
    !fullName.isEmpty
    && emailAddress.isValidEmail
    && password.count > 5
  }
  
  // MARK: - Initializer
  
  init() { setupSegmentedControlUI() }
  
  // MARK: - body
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:20) {
        AuthHeaderView(for: .signUp)
        textFields
        cityPicker.padding(.horizontal,23)
        signUpButton
        signInOption
        Spacer()
      }
      .padding(.top)
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $fullName,
        iconName: "person",
        hint: "input_fullName"
      )
      .focused($fieldContent, equals: .fullName)
      .textInputAutocapitalization(.words)
      .submitLabel(.continue)
      .onSubmit { fieldContent = .emailAddress }
      
      DefaultTextField(
        inputData: $emailAddress,
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
      .submitLabel(.next)
      .onSubmit { fieldContent = .confirmPassword }
      
      SecuredTextField(
        inputData: $password,
        iconName: "lock",
        hint: "input_password_confirm"
      )
      .focused($fieldContent, equals: .confirmPassword)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .customListSetup(
      height: 265,
      rowHeight: 50,
      rowSpacing: 8,
      shadow: 1.0,
      scrollDisabled: true
    )
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading, spacing:12) {
      Text("select_your_city")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("", selection: $selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }.pickerStyle(.segmented)
    }
  }
  
  private var signUpButton: some View {
    Button {
      Task {
        await authViewModel.signUp(
          fullName: fullName,
          email: emailAddress,
          password: password,
          city: selectedCity
        )
      }
    } label: {
      ButtonLabel(
        title: "sign_up_button",
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
  
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing:6) {
        Text("already_a_member?")
          .foregroundStyle(.gray)
        Text("sign_in_title")
          .foregroundStyle(.primaryLabel)
      }
      .font(.footnote)
      .fontWeight(.semibold)
    }
  }
}

#Preview {
  SignUpScreen()
    .environmentObject(AuthViewModel.previewMode)
}
