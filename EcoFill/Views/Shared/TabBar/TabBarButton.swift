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
  let tab: Tab
  @Binding var selectedTab: Tab
  
  var body: some View {
    Button {
      withAnimation(.spring) {
        selectedTab = tab
      }
    } label: {
      HStack(spacing: 10) {
        Image(image)
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
      .background(.white.opacity(selectedTab == tab ? 0.1 : 0.0))
      .clipShape(.capsule)
    }
  }
}

#Preview {
  TabBarButton(title: "Button", image: "home", tab: .home, selectedTab: .constant(.home))
}
