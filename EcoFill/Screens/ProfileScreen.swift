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
  @State private var isPresentedLogOutConfirmation = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      UserDataPreview()
        .padding(.vertical,30)
        .padding(.horizontal,23)
      
      List {
        AppearanceChanger()
        
        Button("Log Out", systemImage: "person.crop.circle.badge.xmark") {
          isPresentedLogOutConfirmation = true
        }
        .font(.custom("LexendDeca-Regular", size: 16))
        .foregroundStyle(.red)
        
        .confirmationDialog("", isPresented: $isPresentedLogOutConfirmation) {
          Button("Log Out", role: .destructive) {
            authenticationVM.signOut()
          }
        } message: {
          Text("Are you sure to log out?")
        }
      }
      .listStyle(.insetGrouped)
      
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image("logo")
            .resizable()
            .frame(width:32, height:32)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink {
            UserPrivateDataPreview()
          } label: {
            Image(systemName: "pencil.and.list.clipboard")
              .imageScale(.large)
              .tint(.accent)
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
