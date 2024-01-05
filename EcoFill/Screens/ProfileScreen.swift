//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct ProfileScreen: View {
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @State private var isPresentedLogOutConfirmation: Bool = false
  @State private var changeTheme: Bool = false
  @Environment(\.colorScheme) private var scheme
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      UserDataPreview()
        .padding(30)
      
      List {
        // MARK: 'Change appearance' button
        Button("Change appearance",systemImage: "moonphase.last.quarter") {
          changeTheme.toggle()
        }
        .foregroundStyle(.customSystemReversed)
        .sheet(isPresented: $changeTheme) {
          AppearanceChanger(scheme: scheme)
            .presentationDetents([.height(180)])
            .presentationBackground(.clear)
            .presentationDragIndicator(.visible)
        }
        
        // MARK: 'Log Out' button
        Button("Log Out",systemImage: "door.right.hand.open") {
          isPresentedLogOutConfirmation.toggle()
        }
        .foregroundStyle(.red)
        .confirmationDialog("",isPresented: $isPresentedLogOutConfirmation) {
          Button("Log Out",role: .destructive) {
            authViewModel.signOut()
          }
        } message: {
          Text("Are you sure to log out?")
        }
      }
      .listStyle(.insetGrouped)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink {
            UserPrivateDataPreview()
          } label: { Text("Edit") }
        }
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ProfileScreen()
    .environmentObject(AuthViewModel())
}

