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
            HStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.primaryWhite.opacity(0.8))
                
                if selectedTab == tab {
                    Text(title)
                        .font(.poppins(.medium, size: 16))
                        .foregroundStyle(.primaryWhite)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                Color.primaryWhite.opacity(selectedTab == tab ? 0.1 : 0)
            )
            .clipShape(.capsule)
        }
    }
}
