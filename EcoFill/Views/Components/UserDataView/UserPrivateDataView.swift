import SwiftUI
import FirebaseAuth


struct UserPrivateDataView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var initials: String = ""
    @State private var email: String = ""
    @State private var currentPassword: String = ""
    @State private var isPresentedEmailReset = false
    @State private var isConfirmingAccountDeletion = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                DataRow(image: .initials, title: initials)
                DataRow(
                    image: userViewModel.isEmailVerified ? .verifiedEmail : .notVerifiedEmail,
                    title: email
                )

                Text(userViewModel.isEmailVerified
                     ? "Email is confirmed"
                     : "To confirm your email, follow the link sent to your email account")
                    .font(.lexendCaption)
                    .foregroundStyle(userViewModel.isEmailVerified ? .accent : .red)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    BaseButton(image: .mail, title: "Reset email", pouring: .cmBlue) {
                        isPresentedEmailReset.toggle()
                    }
                    
                    BaseButton(image: .userDelete, title: "Delete account", pouring: .cmBlue) {
                        isConfirmingAccountDeletion.toggle()
                    }
                    
                    .alert("Confirm password", isPresented: $isConfirmingAccountDeletion) {
                        SecureField("", text: $currentPassword)
                        Button("Delete", role: .destructive) {
                            Task {
                                await userViewModel.deleteUser(
                                    withPassword: currentPassword
                                )
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
                    .presentationCornerRadius(20)
            }
            .alert(item: $userViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton)
            }
            .onAppear {
                setUserData()
                userViewModel.checkEmailVerificationStatus()
            }
        }
    }
}

extension UserPrivateDataView {
    private func setUserData() {
        if let user = userViewModel.currentUser {
            initials = user.initials
            email = user.email
        }
    }
}
