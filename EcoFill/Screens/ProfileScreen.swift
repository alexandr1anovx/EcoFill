//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct ProfileScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @State private var isConfirming = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      UserDataPreview()
        .padding(20)
      
      List {
        AppearanceChanger()
        
        Button {
          isConfirming = true
        } label: {
          HStack(spacing: 20) {
            Image(.xmark)
              .defaultSize()
            Text("Sign Out")
              .font(.lexendBody)
              .foregroundStyle(.red)
          }
        }
        .confirmationDialog("Sign Out", isPresented: $isConfirming) {
          Button("Sign Out", role: .destructive) {
            authenticationVM.signOut()
          }
        }
        
      }
      .listStyle(.insetGrouped)
      
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image(.logo)
            .navBarSize()
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink {
            UserPrivateDataPreview()
          } label: {
            Image(.edit)
              .navBarSize()
          }
        }
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ProfileScreen()
    .environmentObject(AuthenticationViewModel())
}

