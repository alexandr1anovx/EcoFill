import SwiftUI
import FirebaseAuth

struct SettingScreen: View {
  
  @State private var currentEmail = ""
  @State private var newEmail = ""
  @State private var formPassword = ""
  @State private var deletionPassword = ""
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
      VStack(alignment: .leading, spacing: 10) {
        textFields
        emailStatusMessage
        Spacer()
        updateEmailButton
        deleteAccountButton
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
  
  private var textFields: some View {
    List {
      CSTextField(
        icon: .envelope,
        hint: "Current email address",
        inputData: $currentEmail
      )
      .disabled(true)
      
      CSTextField(
        icon: .envelope,
        hint: "New email address",
        inputData: $newEmail
      )
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.next)
      .onSubmit { fieldContent = .password }
      
      CSTextField(
        icon: .lock,
        hint: "Current password",
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
  
  private var emailStatusMessage: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack(spacing: 4) {
        Text("Email status:")
          .font(.footnote)
          .fontWeight(.medium)
        Text(userVM.emailStatus.message)
          .font(.footnote).bold()
          .foregroundStyle(
            userVM.emailStatus == .confirmed ? .green : .red
          )
      }
      Text(userVM.emailStatus.hint)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .padding(.horizontal, 20)
  }
  
  private var updateEmailButton: some View {
    CSButton(title: "Update Email", color: .accent) {
      Task {
        await userVM.updateCurrentEmail(to: newEmail, with: formPassword)
      }
    }
    .disabled(!isValidForm)
    .alert(item: $userVM.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var deleteAccountButton: some View {
    CSButton(title: "Delete Account", color: .red) {
      isShownAlert.toggle()
    }
    .alert("Confirm password", isPresented: $isShownAlert) {
      SecureField("", text: $deletionPassword)
      Button("Delete", role: .destructive) {
        Task {
          await userVM.deleteUser(with: deletionPassword)
        }
      }
    }
  }
  
  // MARK: - Logic Methods
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
