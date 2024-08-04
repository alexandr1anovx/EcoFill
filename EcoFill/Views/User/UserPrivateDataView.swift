//
//  UserPrivateDataPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

@MainActor
struct UserPrivateDataView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
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
                    ResetBtn(img: .mail, data: "email") {
                        isPresentedEmailReset.toggle()
                    }
                    
                    DeleteAccountBtn {
                        isConfirming = true
                    }
                    .alert("Confirm password", isPresented: $isConfirming) {
                        SecureField("", text: $currentPassword)
                        Button("Delete", role: .destructive) {
                            Task {
                                await authenticationVM.deleteUser(
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
            
            .alert(item: $authenticationVM.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton)
            }
            
            .onAppear {
                if let user = authenticationVM.currentUser {
                    initials = user.initials
                    email = user.email
                    city = user.city
                }
                checkEmailVerification()
            }
        }
    }
    
    private func checkEmailVerification() {
        if let user = authenticationVM.userSession {
            isVerifiedEmail = user.isEmailVerified
        }
    }
}

#Preview {
    UserPrivateDataView()
        .environmentObject(AuthenticationViewModel())
}
