//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.

import SwiftUI

struct StationCoordinatesCell: View {
  
  // MARK: - Properties
  var station: Station
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        Text(station.street)
          .font(.lexendCallout)
          .foregroundStyle(.defaultReversed)
        
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
      .font(.lexendBody)
      .buttonStyle(.borderedProminent)
      .tint(.accent)
    }
  }
}

#Preview {
  StationCoordinatesCell(station: .testStation)
}
