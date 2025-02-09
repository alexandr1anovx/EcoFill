import SwiftUI
import FirebaseAuth

enum EmailVerificationStatus: String {
  case verified, notVerified
  
  var message: String {
    switch self {
    case .verified: "Email is verified."
    case .notVerified: "A confirmation link has been sent to your email address."
    }
  }
  
  var iconName: String {
    switch self {
    case .verified: "userCheckmark"
    case .notVerified: "userXmark"
    }
  }
  
  var color: Color {
    switch self {
    case .verified: .accent
    case .notVerified: .red
    }
  }
}

struct SettingScreen: View {
  
  @EnvironmentObject var userVM: UserViewModel
  @State private var isShownEmailView = false
  @State private var isShownAlert = false
  @State private var password = ""
  @State private var verificationStatus = EmailVerificationStatus.notVerified
  
  // MARK: - body
  var body: some View {
    if let user = userVM.currentUser {
      ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        
        VStack(alignment: .leading, spacing: 10) {
          CustomRow(
            data: user.initials,
            image: "user",
            imageColor: .accent
          )
          CustomRow(
            data: user.email,
            image: verificationStatus.iconName,
            imageColor: verificationStatus.color
          )
          Text(verificationStatus.message)
            .font(.poppins(.medium, size: 12))
            .foregroundStyle(.primaryReversed)
          
          Divider()
          
          VStack(alignment: .leading, spacing: 15) {
            updateEmailButton
            deleteAccountButton
          }
          .padding(.top, 10)
          
          Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal)
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
        }
      }
    } else {
      ProgressView("Loading user data...")
    }
  }
  
  // MARK: - Update Email button
  private var updateEmailButton: some View {
    CSButton(title: "Update email", image: "mail", color: .accent) {
      isShownEmailView.toggle()
    }
    .alert(item: $userVM.alertItem) { alert in
      Alert(title: alert.title,
            message: alert.message,
            dismissButton: alert.dismissButton)
    }
    .sheet(isPresented: $isShownEmailView) {
      UpdateEmailScreen()
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(20)
    }
  }
  
  // MARK: - Delete Account button
  private var deleteAccountButton: some View {
    CSButton(title: "Delete account", image: "xmark", color: .primaryRed) {
      isShownAlert.toggle()
    }
    .alert("Confirm password", isPresented: $isShownAlert) {
      SecureField("", text: $password)
      Button("Delete", role: .destructive) {
        Task {
          await userVM.deleteUser(with: password)
        }
      }
    }
  }
}
