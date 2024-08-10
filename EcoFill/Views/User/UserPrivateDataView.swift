import SwiftUI
import FirebaseAuth
import Firebase

@MainActor
struct UserPrivateDataView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - Private Properties
    @State private var initials: String = ""
    @State private var email: String = ""
    @State private var city: String = ""
    @State private var currentPassword: String = ""
    @State private var isPresentedEmailReset = false
    @State private var isConfirming = false
    @State private var isVerifiedEmail = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                InformationRow(
                    img: .initials,
                    text: "Initials:",
                    content: initials
                )
                InformationRow(
                    img: .location,
                    text: "City:",
                    content: city
                )
                InformationRow(
                    img: isVerifiedEmail ? .verified : .notVerified,
                    text: "Email:",
                    content: email
                )
                Text(isVerifiedEmail ? "Email is vefiried." : "Email is unverified. Confirm the link by email and re-login to your account.")
                    .font(.lexendCaption)
                    .foregroundStyle(isVerifiedEmail ? .accent : .red)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    ResetButton(img: .mail, data: "email") {
                        isPresentedEmailReset.toggle()
                    }
                    
                    DeleteAccountButton {
                        isConfirming.toggle()
                    }
                    .alert("Confirm password", isPresented: $isConfirming) {
                        SecureField("", text: $currentPassword)
                        Button("Delete", role: .destructive) {
                            Task {
                                await authenticationViewModel.deleteUser(
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
                ResetEmailView()
                    .presentationCornerRadius(20)
            }
            
            .alert(item: $authenticationViewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton)
            }
            
            .onAppear {
                if let user = authenticationViewModel.currentUser {
                    initials = user.initials
                    email = user.email
                    city = user.city
                }
                checkEmailVerification()
            }
        }
    }
    
    // MARK: - Private Methods
    private func checkEmailVerification() {
        if let user = authenticationViewModel.userSession {
            isVerifiedEmail = user.isEmailVerified
        }
    }
}
