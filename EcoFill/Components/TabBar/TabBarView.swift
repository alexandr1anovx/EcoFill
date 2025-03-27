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
  
  init() { UITabBar.appearance().isHidden = true }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        HomeScreen(isShownTabBar: $isShownTabBar)
          .tag(Tab.home)
        MapScreen(isShownTabBar: $isShownTabBar)
          .tag(Tab.map)
        ProfileScreen(isShownTabBar: $isShownTabBar)
          .tag(Tab.profile)
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
        .padding(11)
        .background(.buttonBackground)
        .clipShape(.capsule)
        .padding(.horizontal, 30)
        .shadow(radius: 2)
      }
    }
  }
}

#Preview {
  TabBarView()
    .environmentObject( MapViewModel() )
    .environmentObject( AuthViewModel() )
    .environmentObject( StationViewModel() )
}

