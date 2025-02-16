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
          ForEach(tabs, id: \.self) { tab in
            TabBarButton(
              title: tab.title,
              image: tab.iconName,
              tab: tab,
              selectedTab: $selectedTab
            )
            if tab != tabs.last {
              Spacer()
            }
          }
        }
        .padding(10)
        .background(.tabBarBackground)
        .clipShape(.capsule)
        .padding(.horizontal, 30)
        .shadow(radius: 2)
      }
    }
  }
}

#Preview {
  TabBarView()
    .environmentObject( StationViewModel() )
    .environmentObject( UserViewModel() )
}
