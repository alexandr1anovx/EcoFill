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
struct UserPrivateDataPreview: View {
  
  // MARK: - Properties
  
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  @State private var fullName: String = ""
  @State private var email: String = ""
  @State private var city: String = ""
  @State private var currentPassword: String = ""
  
  @State private var isPresentedEditingScreen = false
  @State private var isConfirming = false
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
          
          InformationRow(
            image: isEmailVerified ? .verified : .notVerified,
            title: "Email:",
            content: email)
        }
        
        Divider()
        
        // MARK: - Buttons
        VStack(alignment: .leading, spacing: 15) {
          
          UniversalButton(image: .edit, title: "Change data", titleColor: .cmWhite, spacing: 10) {
            isPresentedEditingScreen = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
          
          UniversalButton(image: .xmark, title: "Delete account", titleColor: .cmWhite, spacing: 10) {
            isConfirming = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
          .alert("Confirm Your Password", isPresented: $isConfirming) {
            SecureField("Your password", text: $currentPassword)
            Button("Submit") {
              authenticationVM.deleteUser(withCurrentPassword: currentPassword)
            }
          }
          
          
          
          
          
          
          
          
//          .confirmationDialog("", isPresented: $isConfirming) {
//            Button("Delete", role: .destructive) {
//              authenticationVM.deleteUser()
//            }
//          } message: {
//            Text("All your data will be deleted.")
//          }
        }
        .shadow(radius: 5)
        
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal)
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      
      .sheet(isPresented: $isPresentedEditingScreen) {
        EditingScreen()
          .presentationDetents([.large])
          .presentationCornerRadius(20)
      }
      
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
  UserPrivateDataPreview()
    .environmentObject(AuthenticationViewModel())
}
