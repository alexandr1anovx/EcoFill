//
//  TabBarView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI


struct TabBarView: View {
    
    @State private var selectedTab = TabBarItem.home
    init() { UITabBar.appearance().isHidden = true }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .tag(TabBarItem.home)
                MapScreen()
                    .tag(TabBarItem.map)
                ProfileScreen()
                    .tag(TabBarItem.profile)
            }
            
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
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(.primaryReversed)
            .clipShape(.capsule)
            .padding(.horizontal, 25)
            .shadow(radius: 10)
        }
    }
}
