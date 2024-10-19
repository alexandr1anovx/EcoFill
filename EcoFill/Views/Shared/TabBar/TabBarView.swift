//
//  TabBarView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = TabBarItem.home
    @State private var isShownTabBar: Bool = true
    
    init() { UITabBar.appearance().isHidden = true }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeScreen(isShownTabBar: $isShownTabBar)
                    .tag(TabBarItem.home)
                MapScreen(isShownTabBar: $isShownTabBar)
                    .tag(TabBarItem.map)
                ProfileScreen(isShownTabBar: $isShownTabBar)
                    .tag(TabBarItem.profile)
            }
            
            if isShownTabBar {
                HStack {
                    ForEach(TabBarItem.allCases, id: \.self) { tab in
                        TabBarButton(
                            title: tab.title,
                            image: tab.iconName,
                            tab: tab,
                            selectedTab: $selectedTab
                        )
                        if tab != TabBarItem.allCases.last {
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 11)
                .padding(.horizontal)
                .background(.tabBarBackground)
                .clipShape(.capsule)
                .padding(.horizontal, 25)
                .shadow(radius: 8)
            }
        }
    }
}

