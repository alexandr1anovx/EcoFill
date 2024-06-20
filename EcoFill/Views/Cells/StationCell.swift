//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.

import SwiftUI

struct StationCell: View {
  var station: Station
  var isShownRoute: Bool
  var action: () -> Void
      
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(station.street)
          .font(.lexendCallout)
          .foregroundStyle(.cmReversed)
        
        HStack {
          Text("Schedule:")
            .foregroundStyle(.gray)
          Text(station.schedule)
            .foregroundStyle(.brown)
        }
        .font(.lexendFootnote)
      }
      
      Spacer()
      
      if isShownRoute {
        DismissRouteBtn { action() }
      } else {
        RouteBtn { action() }
      }
    }
  }
}
