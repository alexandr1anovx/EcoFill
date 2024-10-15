import SwiftUI
import FirebaseAuth

struct SettingScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var isPresentedEmailView = false
    @State private var isPresentedDeletionAlert = false
    @State private var password = ""
    
    var body: some View {
        if let user = userVM.currentUser {
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 8) {
                    Image(systemName: "person.fill")
                        .font(.callout)
                        .foregroundStyle(.accent)
                    Text(user.initials)
                        .font(.poppins(.regular, size: 13))
                        .foregroundStyle(.gray)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: userVM.isEmailVerified ?
                          "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                        .font(.callout)
                        .foregroundStyle(userVM.isEmailVerified ? .accent : .red)
                    Text(user.email)
                        .font(.poppins(.regular, size: 13))
                        .foregroundStyle(.gray)
                }
                
                Text(userVM.isEmailVerified ?
                     "Email is confirmed." : "A confirmation link has been sent to your email.")
                .font(.poppins(.medium, size: 12))
                .foregroundStyle(.cmReversed)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    CustomBtn("Update email address", image: "envelope", color: .accent) {
                        isPresentedEmailView.toggle()
                    }
                    CustomBtn("Delete account", image: "xmark", color: .red) {
                        isPresentedDeletionAlert.toggle()
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .navigationTitle("Settings")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackBtn()
                }
            }
            .onAppear {
                userVM.checkEmailVerificationStatus()
            }
            .sheet(isPresented: $isPresentedEmailView) {
                UpdateEmailView()
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(20)
            }
            .alert(item: $userVM.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
            .alert("Confirm password", isPresented: $isPresentedDeletionAlert) {
                SecureField("", text: $password)
                Button("Delete", role: .destructive) {
                    Task {
                        await userVM.deleteUser(with: password)
                    }
                }
            }
        } else {
            ProgressView("Loading user data...")
        }
    }
}
