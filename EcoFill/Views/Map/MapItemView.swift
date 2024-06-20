//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemView: View {
  
  // MARK: - properties
  var station: Station
  @Binding var isShownRoute: Bool
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 15) {
        
        // MARK: - name
        Text(station.name)
          .font(.lexendBody)
        
        // MARK: - address
        
        Row(img: .location, text: station.address)
        
        // MARK: - schedule
        HStack {
          Row(img: .clock, text: "Schedule:")
          Text(station.schedule)
            .font(.lexendCallout)
            .foregroundStyle(.cmReversed)
        }
        
        
        // MARK: - payment
        HStack {
          Row(img: .payment, text: "Pay with:")
          Image(.mastercard)
            .navBarSize()
          Image(.applePay)
            .navBarSize()
        }
        
        // MARK: - fuels
        ScrollableFuelsStack(station: station)
        
        // MARK: - route
        if isShownRoute {
          DismissRouteBtn { isShownRoute = false }
        } else {
          RouteBtn { isShownRoute = true }
        }
        
      }
      .padding(.horizontal, 15)
      .padding(.bottom, 35)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          DismissXBtn()
            .foregroundStyle(.red)
        }
      }
    }
  }
}
