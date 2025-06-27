//
//  LaunchScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.06.2025.
//

import SwiftUI

struct RootView: View {
  
  @State private var isShownLoadingAnimation: Bool = true
  @StateObject var sessionManager: SessionManager
  let firebaseAuthService: AuthServiceProtocol
  let firestoreUserService: UserServiceProtocol
  
  var body: some View {
    Group {
      switch sessionManager.sessionState {

      case .loggedIn(_):
        if isShownLoadingAnimation {
          loadingBackgroundView()
        } else {
          TabBarView(
            firebaseAuthService: firebaseAuthService,
            firestoreUserService: firestoreUserService
          )
        }
      
      case .loggedOut:
        LoginScreen(
          viewModel: LoginViewModel(firebaseAuthService: firebaseAuthService)
        )
      }
    }
    .animation(.easeInOut, value: sessionManager.sessionState)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        isShownLoadingAnimation = false
      }
    }
  }
  
  private func loadingBackgroundView() -> some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack {
        Image(.logo)
          .resizable()
          .frame(width: 120, height: 120)
        ProgressView()
      }
    }
  }
}
