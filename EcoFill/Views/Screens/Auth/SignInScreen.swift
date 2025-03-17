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
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          Image(.logo).frame(height: 80)
          if isFormVisible {
            AuthHeaderView(for: .signIn)
              .padding(.top, 35)
            textFields
            signInButton.padding(.top, 20)
            
            HStack(spacing: 0) {
              forgotPasswordButton
              Spacer()
              signUpOption
            }
            .padding(.horizontal, 23)
            .padding(.top, 18)
          }
          Spacer()
        }
        .padding(.top, 30)
      }
      .onTapGesture {
        UIApplication.shared.hideKeyboard()
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation(.spring(duration: 0.8)) {
            isFormVisible = true
          }
        }
      }
    }
  }
  
  private var textFields: some View {
    List {
      DefaultTextField(
        inputData: $email,
        iconName: "envelope",
        hint: "Email address"
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
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollDisabled(true)
    .frame(height: 145)
    .environment(\.defaultMinListRowHeight, 53)
    .shadow(radius: 1)
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await userVM.signIn(withEmail: email, password: password)
      }
    } label: {
      ButtonLabel("Sign In", textColor: .primaryText, pouring: .buttonBackground)
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
    .alert(item: $userVM.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    Button {
      // action...
    } label: {
      Text("Forgot password?")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .underline(true)
    }
  }
  
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("New member?").foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.").foregroundStyle(.primaryLabel)
      }
    }
    .font(.footnote)
    .fontWeight(.semibold)
  }
}

enum AuthAction {
  case signIn, signUp
  
  var title: String {
    switch self {
    case .signIn: "Sign in."
    case .signUp: "Sign up."
    }
  }
  var subtitle: String {
    switch self {
    case .signIn: "Enter your credentials."
    case .signUp: "Create a new account."
    }
  }
}

struct AuthHeaderView: View {
  let authAction: AuthAction
  
  init(for authAction: AuthAction) {
    self.authAction = authAction
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(authAction.title)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundStyle(.primaryLabel)
      Text(authAction.subtitle)
        .font(.headline)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
    }
  }
}


#Preview {
  SignInScreen()
    .environmentObject(UserViewModel())
}
