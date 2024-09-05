import SwiftUI
import FirebaseAuth

struct UserSettingsView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var password: String = ""
    @State private var isResetEmailScreenShown = false
    @State private var isConfirmingAccountDeletion = false
    
    var body: some View {
        if let user = userVM.currentUser {
            VStack(alignment: .leading, spacing: 10) {
                
                Row(user.initials, image: .user)
                Row(user.email, image: userVM.isEmailVerified ? .verifiedMail : .notVerifiedMail)
                
                Text(userVM.isEmailVerified
                     ? "Email is confirmed."
                     : "A confirmation link has been sent to your email.")
                .font(.system(size: 12))
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(userVM.isEmailVerified ? .accent : .red)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    BaseButton("Reset email", .mail, .cmBlue) {
                        isResetEmailScreenShown.toggle()
                    }
                    BaseButton("Delete account", .userXmark, .cmBlue) {
                        isConfirmingAccountDeletion.toggle()
                    }
                    
                    .alert("Confirm password", isPresented: $isConfirmingAccountDeletion) {
                        SecureField("", text: $password)
                        Button("Delete", role: .destructive) {
                            Task {
                                await userVM.deleteUser(with: password)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
            .sheet(isPresented: $isResetEmailScreenShown) {
                ResetEmailScreen()
                    .interactiveDismissDisabled(true)
                    .presentationCornerRadius(20)
            }
            .alert(item: $userVM.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton)
            }
            .onAppear {
                userVM.checkEmailVerificationStatus()
            }
        } else {
            ProgressView("Loading user data...")
        }
    }
}
