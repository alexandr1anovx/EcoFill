//
//  Cell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import SwiftUI

struct ListCell: View {
  private let item: ListItem
  
  init(for item: ListItem) {
    self.item = item
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: item.iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(item.iconColor)
      VStack(alignment: .leading, spacing: 6) {
        Text(item.title)
          .font(.subheadline)
          .fontWeight(.medium)
          .tint(.primary)
          //.foregroundStyle(.primary)
        if let subtitle = item.subtitle {
          Text(subtitle)
            .font(.caption2)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.leading)
        }
      }
    }
  }
}

#Preview {
  ListCell(for: .settings)
}
