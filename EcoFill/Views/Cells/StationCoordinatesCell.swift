//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.

import SwiftUI

struct StationCoordinatesCell: View {
  
  var station: Station
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(station.street)
          .font(.lexendCallout)
          .foregroundStyle(.cmReversed)
        
        HStack {
          Text("Work schedule:")
            .foregroundStyle(.gray)
          Text(station.schedule)
            .foregroundStyle(.brown)
        }
        .font(.lexendFootnote)
      }
      
      Spacer()
      
      Button("Route") {
        
      }
      .buttonStyle(CustomButtonModifier(pouring: .accent))
      .shadow(radius: 5)
    }
  }
}

#Preview {
  StationCoordinatesCell(station: .testStation)
}
