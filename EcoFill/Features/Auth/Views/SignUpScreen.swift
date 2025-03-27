import SwiftUI

enum City: String, Identifiable, CaseIterable {
  case kyiv, mykolaiv, odesa
  
  var id: Self { self }
  var title: String { rawValue.capitalized }
}

struct SignUpScreen: View {
  
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var selectedCity: City = .mykolaiv
  
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  private var isValidForm: Bool {
    !fullName.isEmpty
    && emailAddress.isValidEmail
    && password.count > 5
  }
  
  init() {
    setupPickerAppearance()
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 0) {
        AuthHeaderView(for: .signUp)
          .padding(.top, 10)
        textFields
        cityPicker
          .padding(.top, 15)
          .padding(.horizontal, 23)
        signUpButton.padding(.top, 25)
        signInOption.padding(.top, 15)
        Spacer()
      }
    }
  }
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $fullName,
        iconName: "person",
        hint: "Full Name"
      )
      .focused($fieldContent, equals: .fullName)
      .textInputAutocapitalization(.words)
      .submitLabel(.continue)
      .onSubmit { fieldContent = .emailAddress }
      
      DefaultTextField(
        inputData: $emailAddress,
        iconName: "envelope",
        hint: "name@example.com"
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
        hint: "Password"
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .frame(height: 195)
    .environment(\.defaultMinListRowHeight, 53)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 1)
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Select your city:")
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
          withFullName: fullName,
          email: emailAddress,
          password: password,
          city: selectedCity
        )
      }
    } label: {
      ButtonLabel("Sign Up", textColor: .primaryText, pouring: .buttonBackground)
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
      HStack(spacing: 5) {
        Text("Already a member?").foregroundStyle(.gray)
        Text("Sign In.").foregroundStyle(.primaryLabel)
      }
      .font(.footnote)
      .fontWeight(.semibold)
    }
  }
  
  // MARK: UI Setup Methods
  private func setupPickerAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .buttonBackground
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.primaryText], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    appearance.backgroundColor = .systemBackground
  }
}

#Preview {
  SignUpScreen()
    .environmentObject( AuthViewModel() )
}

