//
//  TabBarView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct TabBarView: View {
  @State private var selectedTab = Tab.home
  @State private var isShownTabBar = true
  private let tabs = Tab.allCases
  
  let firebaseAuthService: AuthServiceProtocol
  let firestoreUserService: UserServiceProtocol
  @EnvironmentObject var sessionManager: SessionManager
  
  init(
    firebaseAuthService: AuthServiceProtocol,
    firestoreUserService: UserServiceProtocol
  ) {
    UITabBar.appearance().isHidden = true
    self.firebaseAuthService = firebaseAuthService
    self.firestoreUserService = firestoreUserService
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        HomeScreen(isShownTabBar: $isShownTabBar)
          .tag(Tab.home)
        MapScreen(isShownTabBar: $isShownTabBar)
          .tag(Tab.map)
        SettingsScreen(
          isShownTabBar: $isShownTabBar,
          sessionManager: _sessionManager,
          firebaseAuthService: firebaseAuthService,
          firestoreUserService: firestoreUserService
        )
        .tag(Tab.settings)
      }
      
      if isShownTabBar {
        HStack {
          ForEach(tabs) { tab in
            TabBarButton(
              title: tab.title,
              imageName: tab.imageName,
              tab: tab,
              selectedTab: $selectedTab
            )
            if tab != tabs.last {
              Spacer()
            }
          }
        }
        .padding(10)
        .background(.black)
        .clipShape(.capsule)
        .padding(.horizontal,30)
        .shadow(radius: 2)
      }
    }
  }
}
