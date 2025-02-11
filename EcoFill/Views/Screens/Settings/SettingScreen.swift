import SwiftUI
import FirebaseAuth

enum EmailStatus: String {
  case confirmed, notConfirmed
  
  var message: String {
    switch self {
    case .confirmed:
      "Email confirmed."
    case .notConfirmed:
      "Email not confirmed. A confirmation link has been sent to your e-mail address."
    }
  }
  
  var color: Color {
    switch self {
    case .confirmed: .gray
    case .notConfirmed: .red
    }
  }
}

struct SettingScreen: View {
  
  @State private var currentEmail = ""
  @State private var newEmail = ""
  @State private var formPassword = ""
  @State private var deletionPassword = ""
  
  @State private var emailStatus = EmailStatus.notConfirmed
  @State private var isShownAlert = false
  
  @FocusState private var fieldContent: UserDataTextFieldContent?
  @EnvironmentObject var userVM: UserViewModel
  
  private var isValidForm: Bool {
    newEmail.isValidEmail && formPassword.count > 5
  }
  
  // MARK: - body
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack(spacing: 10) {
        textFields
        emailStatusMessage
        
        Spacer()
        updateEmailButton
        deleteAccountButton.padding(.bottom, 10)
      }
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ReturnButton()
        }
      }
      .onAppear {
        userVM.checkEmailVerificationStatus()
        displayEmailAddress()
      }
    }
  }
  
  // MARK: Text Fields
  private var textFields: some View {
    List {
      CSTextField(
        icon: "envelope",
        prompt: "Current email address",
        inputData: $currentEmail
      )
      .disabled(true)
      
      CSTextField(
        icon: "envelope",
        prompt: "New email address",
        inputData: $newEmail
      )
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        icon: "key",
        prompt: "Current password",
        inputData: $formPassword,
        isSecure: true
      )
      .focused($fieldContent, equals: .password)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .frame(height: 190)
    .shadow(radius: 2)
  }
  
  // MARK: - Email Status Message
  private var emailStatusMessage: some View {
    Text(emailStatus.message)
      .font(.caption)
      .foregroundStyle(emailStatus.color)
      .padding(.horizontal, 20)
  }
  
  // MARK: Update Email button
  private var updateEmailButton: some View {
    Button {
      Task {
        await userVM.updateCurrentEmail(to: newEmail, with: formPassword)
      }
    } label: {
      Text("Update Email")
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
  
  // MARK: Delete Account button
  private var deleteAccountButton: some View {
    Button {
      isShownAlert.toggle()
    } label: {
      Text("Delete Account")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(.primaryRed)
    .padding(.horizontal, 20)
    .shadow(radius: 3)
    .alert("Confirm password", isPresented: $isShownAlert) {
      SecureField("", text: $deletionPassword)
      Button("Delete", role: .destructive) {
        Task {
          await userVM.deleteUser(with: deletionPassword)
        }
      }
    }
  }
  
  // MARK: - Methods
  private func displayEmailAddress() {
    if let userEmail = userVM.currentUser?.email {
      currentEmail = userEmail
    } else {
      currentEmail = "No email address"
    }
  }
}

#Preview {
  SettingScreen()
    .environmentObject( UserViewModel() )
    .environmentObject( StationViewModel() )
}
