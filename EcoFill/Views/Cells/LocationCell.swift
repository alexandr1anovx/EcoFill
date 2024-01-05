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
      VStack(alignment: .leading, spacing: 12) {
        Text("\(location.street)")
          .font(.callout)
          .fontWeight(.medium)
          .fontDesign(.rounded)
          .foregroundStyle(.customGreen)
          .lineLimit(2)
        
        Text(location.city)
          .font(.caption)
          .fontWeight(.semibold)
          .fontDesign(.rounded)
          .foregroundStyle(.customSystemReversed)
        
        Text(location.schedule)
          .font(.system(size: 12,
                        weight: .medium,
                        design: .rounded))
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
      Button("On Map") {}
        .foregroundStyle(.red)
    }
  }
}
