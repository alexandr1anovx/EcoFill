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
  
  @State private var isChangingEmail = false
  @State private var isChangingPassword = false
  
  @State private var isConfirmingPassword = false
  @State private var isEmailVerified = false
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 25) {
        
        // MARK: - Information Fields
        VStack(alignment: .leading, spacing: 10) {
          InformationRow(
            image: .initials,
            title: "Initials:",
            content: fullName)
          
          InformationRow(
            image: .city,
            title: "City:",
            content: city)
          
          VStack(alignment: .leading, spacing: 15) {
            
            InformationRow(
              image: isEmailVerified ? .verified : .notVerified,
              title: "Email:",
              content: email)
            
            Text(isEmailVerified ?
                 "" : "Confirmation link has been sent by email.")
            .font(.lexendFootnote)
            .foregroundStyle(.brown)
          }
        }
        
        Divider()
        
        // MARK: - Buttons
        VStack(alignment: .leading, spacing: 15) {
          
          UniversalButton(image: .email, title: "Change email", color: .white, spacing: 10) {
            isChangingEmail = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
          
          UniversalButton(image: .password, title: "Change password", color: .white, spacing: 10) {
            isChangingPassword = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
          
          UniversalButton(image: .xmarkWhite, title: "Delete account", color: .white, spacing: 10) {
            isConfirmingPassword = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .red))
          
          .alert("Confirm password", isPresented: $isConfirmingPassword) {
            SecureField("", text: $currentPassword)
            Button("Delete") {
              Task {
                await authenticationVM.deleteUser(currentPassword)
              }
            }
            Button("Cancel", role: .cancel) {}
          }
        }
        .shadow(radius: 5)
        
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal)
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      
      // MARK: - Sheets
      
      .sheet(isPresented: $isChangingEmail) {
        ResetEmailView()
          .presentationCornerRadius(20)
      }
      
      .sheet(isPresented: $isChangingPassword) {
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
