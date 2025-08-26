//
//  LaunchScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.06.2025.
//

import SwiftUI

struct RootView: View {
  @Environment(SessionManager.self) var sessionManager
  @State private var showAnimation = true
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  var body: some View {
    Group {
      switch sessionManager.state {
      case .loggedIn(_):
        if showAnimation {
          ProgressView()
        } else {
          TabBarView(authService: authService, userService: userService)
        }
      case .loggedOut:
        LoginScreen(authService: authService, userService: userService)
      }
    }
    .animation(.easeInOut, value: sessionManager.state)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        showAnimation = false
      }
    }
  }
}
