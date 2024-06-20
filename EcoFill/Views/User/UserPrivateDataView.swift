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
  
  // MARK: - properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var city: String = ""
  @State private var currentPassword: String = ""
  @State private var isShownResetEmail = false
  @State private var isConfirming = false
  @State private var isVerifiedEmail = false
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 20) {
        
        // MARK: - information fields
        VStack(alignment: .leading, spacing: 10) {

          InformationRow(
            img: .initials,
            text: "Initials:",
            content: fullName)
          
          InformationRow(
            img: .location,
            text: "City:",
            content: city)
          
          VStack(alignment: .leading, spacing: 10) {
            InformationRow(
              img: isVerifiedEmail ? .verified : .notVerified,
              text: "Email:",
              content: email)
            
            Text(isVerifiedEmail ? "Email is vefiried." : "Email is unverified. Confirm the link by email and re-login to your account.")
            .font(.lexendCaption)
            .foregroundStyle(isVerifiedEmail ? .accent : .red)
          }
        }
        
        Divider()
        
        // MARK: - buttons
        
        VStack(alignment: .leading, spacing: 15) {
          ResetBtn(img: .mail, data: "email") {
            isShownResetEmail = true
          }
          
          DeleteAccountBtn { isConfirming = true }
            .alert("Confirm password", isPresented: $isConfirming) {
              SecureField("", text: $currentPassword)
              Button("Delete", role: .destructive) {
                Task {
                  await authenticationVM.deleteUser(
                    withPassword: currentPassword)
              }
            }
          }
        }
        
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal)
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      
      // MARK: - Sheets
      .sheet(isPresented: $isShownResetEmail) {
        ResetEmailView()
          .presentationCornerRadius(20)
      }
      
      // MARK: - Alert
      .alert(item: $authenticationVM.alertItem) { alertItem in
        Alert(
          title: alertItem.title,
          message: alertItem.message,
          dismissButton: alertItem.dismissButton)
      }
      
      .onAppear {
        // Load user data.
        if let user = authenticationVM.currentUser {
          fullName = user.fullName
          email = user.email
          city = user.city
        }
        
        // Verification for email confirmation by user.
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
