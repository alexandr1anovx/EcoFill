//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct StationLocationCell: View {
  var station: Station
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing:12) {
        Text(station.street)
          .font(.callout)
          .fontWeight(.medium)
          .fontDesign(.rounded)
          .foregroundStyle(.accent)
          .lineLimit(2)
        
        Text(station.city)
          .font(.caption)
          .fontWeight(.semibold)
          .fontDesign(.rounded)
          .foregroundStyle(.defaultReversed)
        
        Text(station.schedule)
          .font(.system(size: 12,
                        weight: .medium,
                        design: .rounded))
          .foregroundStyle(.gray)
      }
      
      Spacer()
      
      Button("Route") {
        
      }
      .buttonStyle(.bordered)
      .tint(.defaultReversed)
    }
  }
}

#Preview { StationLocationCell(station: .testStation) }
