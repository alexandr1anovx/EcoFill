import SwiftUI

enum City: String, Identifiable, CaseIterable {
  case kyiv
  case mykolaiv
  case odesa
  
  var id: Self { self }
  var title: String { self.rawValue.capitalized }
}

struct SignUpScreen: View {
  
  @State private var username = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  @Environment(\.dismiss) var dismiss
  
  private var isValidForm: Bool {
    !username.isEmpty
    && emailAddress.isValidEmail
    && password.count > 5
  }
  
  // Picker Style Customization
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .accent
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .systemBackground
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack(spacing: 15) {
        textFields
        cityPicker.padding(.horizontal, 23)
        signUpButton.padding(.top, 10)
        signInOption
        Spacer()
      }
      .navigationTitle("Sign Up")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ReturnButton()
        }
      }
    }
  }
  
  private var textFields: some View {
    List {
      CSTextField(
        icon: .user,
        hint: "Full Name",
        inputData: $username
      )
      .focused($fieldContent, equals: .username)
      .textInputAutocapitalization(.words)
      .submitLabel(.next)
      .onSubmit { fieldContent = .emailAddress }
      
      CSTextField(
        icon: .envelope,
        hint: "name@example.com",
        inputData: $emailAddress
      )
      .focused($fieldContent, equals: .emailAddress)
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        icon: .lock,
        hint: "Password",
        inputData: $password,
        isSecure: true
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .frame(height: 185)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 2)
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("Select your city:")
        .font(.footnote)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Picker("", selection: $userVM.selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }.pickerStyle(.segmented)
    }
  }
  
  private var signUpButton: some View {
    Button {
      Task {
        await userVM.signUp(
          withInitials: username,
          email: emailAddress,
          password: password,
          city: userVM.selectedCity
        )
      }
    } label: {
      Text("Sign Up")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(.accent)
    .padding(.horizontal, 20)
    .shadow(radius: 5)
    .disabled(!isValidForm)
    .alert(item: $userVM.alertItem) { alert in
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
      HStack(spacing: 8) {
        Text("Already a member?")
          .font(.footnote)
          .fontDesign(.monospaced)
          .foregroundStyle(.gray)
        Text("Sign In.")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.accent)
      }
    }
  }
}

#Preview {
  SignUpScreen()
    .environmentObject( UserViewModel() )
}
