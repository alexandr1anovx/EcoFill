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
  
  // MARK: - Properties
  
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var city: String = ""
  @State private var currentPassword: String = ""
  
  @State private var isPresentedEmailChange = false
  @State private var isPresentedPasswordChange = false
  
  @State private var isConfirming = false
  @State private var isEmailVerified = false
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 20) {
        
        // MARK: - Information Fields
        VStack(alignment: .leading, spacing: 10) {
          InformationRow(
            image: .initials,
            title: "Initials:",
            content: fullName)
          
          InformationRow(
            image: .building,
            title: "City:",
            content: city)
          
          VStack(alignment: .leading, spacing: 10) {
            InformationRow(
              image: isEmailVerified ? .verified : .notVerified,
              title: "Email:",
              content: email)
            
            Text(isEmailVerified ?
                 "Email is vefiried." : "Email is unverified. Confirm the link by email and re-login to your account.")
            .font(.lexendCaption1)
            .foregroundStyle(isEmailVerified ? .accent : .red)
          }
        }
        
        Divider()
        
        // MARK: - Buttons
        VStack(alignment: .leading, spacing: 15) {
          
          ChangeEmailBtn { isPresentedEmailChange = true }
          ChangePasswordBtn { isPresentedPasswordChange = true }
          
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
      
      .sheet(isPresented: $isPresentedEmailChange) {
        ResetEmailView()
          .presentationCornerRadius(20)
      }
      
      .sheet(isPresented: $isPresentedPasswordChange) {
        ResetPasswordView()
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
      isEmailVerified = user.isEmailVerified
    }
  }
}

#Preview {
  UserPrivateDataView()
    .environmentObject(AuthenticationViewModel())
}
