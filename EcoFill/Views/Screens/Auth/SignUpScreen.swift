import SwiftUI

enum City: String, Identifiable, CaseIterable {
  case kyiv, mykolaiv, odesa
  var id: Self { self }
  var title: String { self.rawValue.capitalized }
}

struct SignUpScreen: View {
  
  @State private var username = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isValidForm: Bool {
    !username.isEmpty
    && emailAddress.isValidEmail
    && password.count > 5
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      
      formStack
        .padding(.top, 25)
        .padding(.horizontal, 15)
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
          fieldContent = .username
        }
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ReturnButton()
          }
          ToolbarItem(placement: .topBarTrailing) {
            signUpButton
          }
        }
    }
  }
  
  // MARK: - Form Stack
  private var formStack: some View {
    VStack(alignment: .leading, spacing: 20) {
      CSTextField(
        header: "Username",
        placeholder: "Full Name",
        data: $username
      )
      .focused($fieldContent, equals: .username)
      .textInputAutocapitalization(.words)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .emailAddress }
      
      CSTextField(
        header: "Email address",
        placeholder: "name@example.com",
        data: $emailAddress
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        header: "Password",
        placeholder: "At least 6 characters.",
        data: $password,
        isSecure: true
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
      
      cityPicker
      Spacer()
    }
  }
  
  // MARK: - City Picker
  private var cityPicker: some View {
    Picker("", selection: $userVM.selectedCity) {
      ForEach(City.allCases) { city in
        Text(city.title)
      }
    }
    .pickerStyle(.segmented)
  }
  
  // MARK: - Sign Up Button
  private var signUpButton: some View {
    Button("Sign Up") {
      Task {
        await userVM.signUp(
          withInitials: username,
          email: emailAddress,
          password: password,
          city: userVM.selectedCity
        )
      }
    }
    .foregroundStyle(.accent)
    .disabled(!isValidForm)
    .opacity(isValidForm ? 1 : 0.5)
    .alert(item: $userVM.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
}
