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
  
  var body: some View {
    VStack(alignment: .leading, spacing: 13) {
      
      // MARK: - Coordinates
      VStack(alignment: .leading, spacing: 13) {
        Text(station.name)
          .font(.lexendTitle3)
        
        Text(station.address)
          .font(.lexendFootnote)
          .foregroundStyle(.gray)
        
        // MARK: - Work schedule
        HStack {
          Text("Work schedule:")
            .font(.lexendFootnote)
            .foregroundStyle(.gray)
          
          Text(station.schedule)
            .font(.lexendCallout)
            .foregroundStyle(.brown)
        }
      }
      
      // MARK: - Fuels
      ScrollableFuelsStack(station: station)
      
      // MARK: - Payment methods
      HStack(spacing: 8) {
        Text("Pay with:")
          .font(.lexendFootnote)
          .foregroundStyle(.gray)
        Image("mastercard")
          .resizable()
          .frame(width: 40, height: 40)
        Image("applePay")
          .resizable()
          .frame(width: 40, height: 40)
        Image("cash")
          .resizable()
          .frame(width: 40, height: 40)
      }
      
      Button("Get directions", systemImage: "figure.walk") {
        // action
      }
      .font(.lexendBody)
      .buttonStyle(.borderedProminent)
      .shadow(radius: 6)
    }
    .padding(.horizontal, 15)
  }
}

#Preview {
  MapItemPreview(station: .testStation)
}
