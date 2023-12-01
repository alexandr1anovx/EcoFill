//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct LocationCell: View {
  var location: Location
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 15) {
        Text("\(location.street)")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(.customGreen)
          .lineLimit(2)
        
        Text(location.city)
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundStyle(.gray)
        
        Text(location.schedule)
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundStyle(.customSystemReversed)
      }
      
      Spacer()
      
      Button("Карта") {}
        .font(.callout)
        .buttonStyle(.borderedProminent)
        .tint(Color.customBlack)
        .foregroundStyle(.white)
    }
  }
}

#Preview {
  LocationCell(location: Location(id: 1,street: "вул. Хрещатик",city: "м. Київ", schedule: "Пн-Сб: 09:00-20:00"))
}
