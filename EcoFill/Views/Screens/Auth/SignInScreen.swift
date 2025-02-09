import SwiftUI

struct SignInScreen: View {
  
  @State private var isFormVisible = false
  @State private var email = ""
  @State private var password = ""
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isValidForm: Bool {
    email.isValidEmail && password.count > 5
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        VStack(alignment: .leading, spacing: 20) {
          logoImage
          
          if isFormVisible {
            textFieldStack
            signInButton
            signUpOption
          }
          Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
      }
      .onTapGesture {
        UIApplication.shared.hideKeyboard()
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation(.spring(duration: 1)) {
            isFormVisible = true
          }
        }
      }
    }
  }
  
  // MARK: - Logo Image
  private var logoImage: some View {
    HStack {
      Spacer()
      Image("logo").frame(height: 100)
      Spacer()
    }
  }
  
  // MARK: - Text Field Stack
  private var textFieldStack: some View {
    VStack(spacing: 20) {
      CSTextField(
        header: "Email",
        placeholder: "Enter your email address",
        data: $email
      )
      .focused($fieldContent, equals: .emailAddress)
      .textInputAutocapitalization(.never)
      .keyboardType(.emailAddress)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        header: "Password",
        placeholder: "Enter your password",
        data: $password,
        isSecure: true
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
  }
  
  // MARK: - Sign In Button
  private var signInButton: some View {
    CSButton(title: "Sign In", image: "userFill", color: .accent) {
      Task {
        await userVM.signIn(with: email, password: password)
      }
    }
    .disabled(!isValidForm)
    .opacity(isValidForm ? 1.0 : 0.5)
  }
  
  // MARK: - Sign Up Option
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .font(.poppins(.regular, size: 14))
        .foregroundStyle(.gray)
      NavigationLink("Sign Up") {
        SignUpScreen()
      }
      .font(.poppins(.medium, size: 16))
      .foregroundStyle(.accent)
      .alert(item: $userVM.alertItem) { alert in
        Alert(
          title: alert.title,
          message: alert.message,
          dismissButton: alert.dismissButton
        )
      }
    }
  }
}
