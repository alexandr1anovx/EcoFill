//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemPreview: View {
  // MARK: - Properties
  var station: Station
  
  // MARK: - body
  var body: some View {
    VStack(alignment: .center, spacing:15) {
      Text(station.name)
        .font(.headline)
        .foregroundStyle(.defaultReversed)
      
      Divider()
      
      Text(station.address)
        .font(.subheadline)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.leading)
      
      Text(station.schedule)
        .font(.callout).bold()
        .foregroundStyle(.defaultReversed)
        .multilineTextAlignment(.leading)
      
      Button("Get direction") {
        // route
      }
      .fontWeight(.medium)
      .tint(.blue)
      .buttonStyle(.borderedProminent)
      .padding(.top,15)
    }
  }
}

// MARK: - Preview
#Preview {
  MapItemPreview(station: .testStation)
}
