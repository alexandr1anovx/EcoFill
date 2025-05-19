import SwiftUI

struct SignUpScreen: View {
  
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var confirmedPassword = ""
  @State private var selectedCity = City.mykolaiv
  @FocusState private var fieldContent: InputFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
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
        VStack(spacing:20) {
          inputView
          cityPickerView.padding(.horizontal)
          signUpButton
          loginOptionView
        }
      }
    }
    .navigationTitle("Registration")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: - Auxilary UI Components
  
  private var inputView: some View {
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
        inputData: $confirmedPassword,
        iconName: "lock",
        hint: "input_password_confirm"
      )
      .focused($fieldContent, equals: .confirmPassword)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .customListStyle(
      height: 260,
      rowHeight: 50,
      rowSpacing: 8,
      shadow: 1.0,
      scrollDisabled: true
    )
  }
  
  private var cityPickerView: some View {
    HStack(spacing:0) {
      Text("select_your_city")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("", selection: $selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }.pickerStyle(.menu)
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
        title: "register_button",
        textColor: .white,
        pouring: .green
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
  SignUpScreen()
    .environmentObject(AuthViewModel.previewMode)
}
