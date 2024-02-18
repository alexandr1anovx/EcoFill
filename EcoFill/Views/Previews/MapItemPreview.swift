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
    HStack {
      VStack(alignment: .leading,spacing: 15) {
        
        // MARK: - Coordinates and fuel types
        VStack(alignment: .leading,spacing:10) {
          Text(station.name)
            .font(.system(size: 18,
                          weight: .medium,
                          design: .rounded))
          Text(station.address)
            .font(.footnote)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.gray)
        }
        
        VStack(alignment: .leading,spacing:5) {
          HStack {
            Text("Work schedule:")
              .font(.footnote)
              .foregroundStyle(.gray)
            Text(station.schedule)
              .font(.callout)
              .foregroundStyle(.defaultOrange)
          }
          .fontWeight(.medium)
          .fontDesign(.rounded)
        }
        
        ScrollableFuelsStack(station: station)
          .padding(.top,5)
        
        // MARK: - Payment methods and work schedule
        HStack(spacing:10) {
          Text("Payment methods:")
            .font(.footnote)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.gray)
          Image("visa")
            .resizable()
            .frame(width:40,height:40)
          Image("applePay")
            .resizable()
            .frame(width:40,height:40)
          Image("cash")
            .resizable()
            .frame(width:40,height:40)
        }
        
        // MARK: - Get direction
        Button("Get directions", systemImage: "figure.walk") {
          
        }
        .font(.headline)
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .buttonStyle(.borderedProminent)
        .shadow(radius:6)
        .padding(.top,5)
      }
      Spacer()
    }
    .padding(.horizontal,13)
  }
}

#Preview {
  MapItemPreview(station: .testStation)
}
