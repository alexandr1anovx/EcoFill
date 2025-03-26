//
//  Cell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import SwiftUI

struct ListCell: View {
  
  let title: String
  let subtitle: String
  let iconName: String
  let iconColor: Color
  
  init(
    title: String,
    subtitle: String,
    icon: String,
    iconColor: Color
  ) {
    self.title = title
    self.subtitle = subtitle
    self.iconName = icon
    self.iconColor = iconColor
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(iconColor)
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .font(.subheadline)
          .fontWeight(.medium)
          .foregroundStyle(.primaryLabel)
        Text(subtitle)
          .font(.caption2)
          .foregroundStyle(.gray)
          .multilineTextAlignment(.leading)
      }
    }
  }
}

#Preview {
  ListCell(
    title: "Settings",
    subtitle: "Change your personal data.",
    icon: "gear",
    iconColor: .white
  )
}
