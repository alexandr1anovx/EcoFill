//
//  TabBarView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct TabBarView: View {
  @Environment(SessionManager.self) var sessionManager
  @Environment(MapViewModel.self) var mapViewModel
  
  @State private var selectedTab = Tab.home
  @State private var showTabBar = true
  private let tabs = Tab.allCases
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
    self.authService = authService
    self.userService = userService
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        HomeScreen(showTabBar: $showTabBar)
          .tag(Tab.home)
        MapScreen(viewModel: mapViewModel)
          .tag(Tab.map)
        MoreScreen(
          showTabBar: $showTabBar,
          authService: authService,
          userService: userService
        )
        .tag(Tab.more)
      }
      
      if showTabBar {
        HStack {
          ForEach(tabs) { tab in
            TabBarButton(
              title: tab.title,
              imageName: tab.iconName,
              tab: tab,
              selectedTab: $selectedTab
            )
            if tab != tabs.last {
              Spacer()
            }
          }
        }
        .padding(10)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal,30)
      }
    }
  }
}

#Preview {
  TabBarView(authService: AuthService(), userService: MockUserService())
    .environment(StationViewModel.mockObject)
    .environment(MapViewModel.mockObject)
    .environment(SessionManager(userService: MockUserService(), isForPreview: true))
}
