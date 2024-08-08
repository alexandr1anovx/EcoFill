//
//  LocationCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.

import SwiftUI

struct StationCell: View {
    
    // MARK: - Public Properties
    let station: Station
    let isShownRoute: Bool
    let action: () -> Void
    
    // MARK: - body
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.lexendCallout)
                    .foregroundStyle(.cmReversed)
                Row(img: .clock, text: station.schedule)
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
