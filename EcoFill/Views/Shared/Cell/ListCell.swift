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
  let icon: ImageResource
  let iconColor: Color
  
  var body: some View {
    HStack(spacing: 15) {
      Image(icon)
        .foregroundStyle(iconColor)
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.system(size: 15))
          .fontWeight(.medium)
          .foregroundStyle(.primaryReversed)
        Text(subtitle)
          .font(.caption)
          .foregroundStyle(.gray)
          .multilineTextAlignment(.leading)
      }
      .fontDesign(.monospaced)
    }
  }
}

#Preview {
  ListCell(
    title: "Title",
    subtitle: "Description",
    icon: .user,
    iconColor: .accent
  )
}
