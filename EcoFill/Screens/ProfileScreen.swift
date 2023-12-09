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
        .padding(40)
      
      List {
        /// Settings section
        Section {
          NavigationLink {
            SettingsScreen()
          } label: {
            SettingsCell(title: "Налаштування", iconName: "slider.horizontal.3", background: .customRed)
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
      
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
        }
        ToolbarItem(placement: .topBarTrailing) {
          NavigationLink("Змінити") {
            UserPrivateDataPreview()
          }
          .tint(.customGreen)
          .fontWeight(.medium)
          .fontDesign(.rounded)
        }
      }
      .navigationTitle("Профіль")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ProfileScreen()
    .environmentObject(UserViewModel())
}

