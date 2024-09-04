import SwiftUI
import FirebaseAuth

struct UserPrivateDataView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var password: String = ""
    @State private var isPresentedEmailReset = false
    @State private var isConfirmingAccountDeletion = false
    
    var body: some View {
        if let user = userViewModel.currentUser {
            VStack(alignment: .leading, spacing: 10) {
                
                Row(user.initials, image: .user)
                Row(user.email, image: userViewModel.isEmailVerified ? .verifiedMail : .notVerifiedMail)
                
                Text(userViewModel.isEmailVerified
                     ? "Email is confirmed."
                     : "A confirmation link has been sent to your email.")
                .font(.system(size: 12))
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(userViewModel.isEmailVerified ? .accent : .red)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    BaseButton("Reset email", .mail, .cmBlue) {
                        isPresentedEmailReset.toggle()
                    }
                    BaseButton("Delete account", .userXmark, .cmBlue) {
                        isConfirmingAccountDeletion.toggle()
                    }
                    
                    .alert("Confirm password", isPresented: $isConfirmingAccountDeletion) {
                        SecureField("", text: $password)
                        Button("Delete", role: .destructive) {
                            Task {
                                await userViewModel.deleteUser(with: password)
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
            
            .sheet(isPresented: $isPresentedEmailReset) {
                ResetEmailScreen()
                    .interactiveDismissDisabled(true)
                    .presentationCornerRadius(20)
            }
            .alert(item: $userViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton)
            }
            .onAppear {
                userViewModel.checkEmailVerificationStatus()
            }
        } else {
            ProgressView("Loading user data...")
        }
    }
}
