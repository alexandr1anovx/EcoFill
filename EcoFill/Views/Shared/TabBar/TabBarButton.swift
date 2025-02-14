//
//  TabBarButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct TabBarButton: View {
  
  let title: String
  let image: String
  let tab: TabBarItem
  @Binding var selectedTab: TabBarItem
  
  var body: some View {
    Button {
      withAnimation(.spring) {
        selectedTab = tab
      }
    } label: {
      HStack(spacing: 8) {
        Image(image)
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundStyle(.tabBarIcon)
        
        if selectedTab == tab {
          Text(title)
            .font(.callout).bold()
            .fontDesign(.monospaced)
            .foregroundStyle(.tabBarIcon)
        }
      }
      .padding(.vertical, 10)
      .padding(.horizontal)
      .background(.white.opacity(selectedTab == tab ? 0.07 : 0.0))
      .clipShape(.capsule)
    }
  }
}

#Preview {
  TabBarButton(title: "Button", image: "man", tab: .home, selectedTab: .constant(.home))
}
