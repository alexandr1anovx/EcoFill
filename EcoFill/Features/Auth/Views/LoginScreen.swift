import SwiftUI

struct LoginScreen: View {
  
  @State private var emailAddress = ""
  @State private var password = ""
  @FocusState private var fieldContent: InputContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: - body
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:20) {
          Text("Login")
            .font(.title)
            .fontWeight(.bold)
          inputView
          loginButton
          forgotPasswordButton
          registerOptionView
          //Spacer()
        }
      }
      //.navigationTitle("Login")
      //.navigationBarTitleDisplayMode(.large)
    }
  }
  
  // MARK: - Components
  
  private var inputView: some View {
    VStack {
      InputField(for: .emailAddress, data: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .submitLabel(.continue)
        .onSubmit { fieldContent = .password }
      
      InputField(for: .password, data: $password)
        .focused($fieldContent, equals: .password)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .padding(.top)
    .padding(.horizontal)
  }
  
  private var loginButton: some View {
    Button {
      Task {
        await authViewModel.logIn(email: emailAddress, password: password)
        password = ""
      }
    } label: {
      ButtonLabel(
        title: "login_title",
        textColor: .white,
        pouring: .accent
      )
    }
    .padding(.horizontal)
    .disabled(emailAddress.isEmpty && password.isEmpty)
    .opacity(emailAddress.isEmpty && password.isEmpty ? 0.4 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.primaryButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    NavigationLink {
      ResetPasswordScreen()
    } label: {
      Text("forgot_password")
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  private var registerOptionView: some View {
    HStack(spacing: 5) {
      Text("new_member?").foregroundStyle(.gray)
      NavigationLink {
        RegistrationScreen()
      } label: {
        Text("register_title").fontWeight(.semibold)
      }
    }.font(.footnote)
  }
}

#Preview {
  LoginScreen()
    .environmentObject(AuthViewModel.previewMode)
}
