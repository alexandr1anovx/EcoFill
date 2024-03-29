//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemView: View {
  
  // MARK: - Properties
  var station: Station
  var action: () -> Void?
  
  var body: some View {
    NavigationStack {
      
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - Station name
        Text(station.name)
          .font(.lexendBody)
        
        // MARK: - Address
        Row(img: .location, text: station.address)
        
        // MARK: - Schedule
        HStack {
          Row(img: .clock, text: "Schedule:")
          Text(station.schedule)
            .font(.lexendCallout)
            .foregroundStyle(.cmReversed)
        }
        
        // MARK: - Payment
        HStack {
          Row(img: .cash, text: "Pay with:")
          Image(.mastercard)
            .navBarSize()
          Image(.applePay)
            .navBarSize()
        }
        
        // MARK: - Fuels
        ScrollableFuelsStack(station: station)
        
        // MARK: - Get directions
        GetDirectionsBtn {
          // action
        }
      }
      .padding(.horizontal, 15)
      .padding(.bottom, 35)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          DismissXButton()
        }
      }
    }
  }
}

// MARK: - Row
struct Row: View {
  var img: ImageResource
  var text: String?
  
  var body: some View {
    HStack {
      Image(img)
        .defaultSize()
      
      Text(text ?? "")
        .font(.lexendFootnote)
        .foregroundStyle(.gray)
    }
  }
}


#Preview {
  MapItemView(station: .testStation, action: {})
}
