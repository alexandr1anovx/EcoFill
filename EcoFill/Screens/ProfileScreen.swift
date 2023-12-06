//
//  ProfileScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI

struct ProfileScreen: View {
  @State private var isPresentedLogOutConfirmation: Bool = false
  
  var body: some View {
    NavigationStack {
      UserDataPreview()
      NavigationLink("Редагувати") {
        UserPrivateDataPreview()
      }
      .fontWeight(.medium)
      .tint(.customBlack)
      .buttonStyle(.borderedProminent)
      .padding(.top, 5)
      
      List {
        /// Settings section
        Section {
          NavigationLink {
            SettingsScreen()
          } label: {
            SettingsCell(title: "Налаштування", iconName: "gear", background: .customBlack)
          }
        } footer: {
          Text("Змінити тему застосунку, налаштувати повідомлення.")
        }
        
        /// Log Out section
        Section {
          Button("Вийти", systemImage: "door.right.hand.open") {
            isPresentedLogOutConfirmation.toggle()
          }
          .foregroundStyle(.red)
          .confirmationDialog("Log Out", isPresented: $isPresentedLogOutConfirmation) {
            Button("Log Out", role: .destructive) {
              // Log Out action ...
            }
          } message: {
            Text("Are you sure you want to log out?")
          }
        } footer: {
          Text("Вийти з вашого облікового запису.")
        }
      }
      .listStyle(.insetGrouped)
      .padding(.top, 20)
    }
}

#Preview {
    ProfileScreen()
}
