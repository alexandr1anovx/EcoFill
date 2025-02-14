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
        VStack(spacing: 15) {
          Image(.logo).frame(height: 50)
          if isFormVisible {
            textFields
            signInButton
            signUpOption
          }
          Spacer()
        }
        .padding(.top, 50)
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
      CSTextField(
        icon: .envelope,
        hint: "Email address",
        inputData: $email
      )
      .focused($fieldContent, equals: .emailAddress)
      .textInputAutocapitalization(.never)
      .keyboardType(.emailAddress)
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
    .listStyle(.insetGrouped)
    .frame(height: 140)
    .scrollContentBackground(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 1)
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await userVM.signIn(with: email, password: password)
      }
    } label: {
      Text("Sign In")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(.accent)
    .padding(.horizontal, 20)
    .shadow(radius: 3)
    .disabled(!isValidForm)
    .alert(item: $userVM.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .font(.footnote)
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.")
          .font(.callout).bold()
          .foregroundStyle(.accent)
      }
    }
    .fontDesign(.monospaced)
  }
}

#Preview {
  SignInScreen()
    .environmentObject(UserViewModel())
}
