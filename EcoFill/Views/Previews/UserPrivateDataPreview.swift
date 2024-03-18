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
  @State private var isPresentedEditingMode = false
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

          Button("Edit information", systemImage: "pencil") {
            isPresentedEditingMode = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
          
          Button("Delete account", systemImage: "xmark.circle.fill") {
            isConfirming = true
          }
          .buttonStyle(CustomButtonModifier(pouring: .red))
          
          .confirmationDialog("", isPresented: $isConfirming) {
            Button("Delete", role: .destructive) {
              authenticationVM.deleteUser()
            }
          } message: {
            Text("All your data will be deleted.")
          }
        }
        .shadow(radius: 5)
        
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal)
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      
      .sheet(isPresented: $isPresentedEditingMode) {
        EditingScreen()
          .presentationDetents([.large])
          .presentationCornerRadius(20)
          .presentationDragIndicator(.visible)
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
    if let userSession = authenticationVM.userSession {
      isEmailVerified = userSession.isEmailVerified
    }
  }
}

#Preview {
  UserPrivateDataPreview()
    .environmentObject(AuthenticationViewModel())
}


