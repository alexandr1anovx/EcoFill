//
//  TabBarButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

struct TabBarButton: View {
  
  let title: String
  let imageName: String
  let tab: Tab
  @Binding var selectedTab: Tab
  
  var body: some View {
    Button {
      withAnimation { selectedTab = tab }
      let impact = UISelectionFeedbackGenerator()
      impact.selectionChanged()
    } label: {
      HStack(spacing: 10) {
        Image(systemName: imageName)
          .foregroundStyle(.primaryText)
        if selectedTab == tab {
          Text(title)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.primaryText)
        }
      }
      .padding(.vertical, 12)
      .padding(.horizontal)
      .background(.white.opacity(selectedTab == tab ? 0.1 : 0.0))
      .clipShape(.capsule)
    }
  }
}

#Preview {
  TabBarButton(
    title: "Button",
    imageName: "house",
    tab: .home,
    selectedTab: .constant(.home)
  )
}
