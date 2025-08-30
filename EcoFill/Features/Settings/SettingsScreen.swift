//
//  SettingsScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.08.2025.
//

import SwiftUI

struct SettingsScreen: View {
  @Environment(SessionManager.self) var sessionManager
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  var body: some View {
    NavigationView {
      Form {
        Section("General") {
          ColorThemeSelectionView()
          
        }
        ChangeLanguageCell()
        NavigationLink {
          ProfileScreen(
            authService: authService,
            userService: userService,
            sessionManager: sessionManager
          ) 
        } label: {
          Text("Edit Personal Data")
            .font(.callout)
        }
      }
      .listRowSpacing(8)
    }
  }
}

private extension SettingsScreen {
  struct ChangeLanguageCell: View {
    @State private var isShownAlert = false
    
    var body: some View {
      HStack {
        Text("Language")
          .font(.callout)
        Spacer()
        Button("Change in settings") {
          isShownAlert.toggle()
        }
        .tint(.blue)
        
      }
      .alert("Change App Language", isPresented: $isShownAlert) {
        Button("Cancel", role: .cancel) { isShownAlert = false }
        Button("Continue") { openAppSettings() }
      } message: {
        Text("You will be redirected to the Settings screen to change the app's language. Do you want to continue?")
      }
    }
    
    private func openAppSettings() {
      guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
      }
    }
  }
}

#Preview {
  SettingsScreen(authService: AuthService(), userService: UserService())
    .environment(SessionManager.mockObject)
}
