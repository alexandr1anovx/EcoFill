//
//  LocationItemPreview.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapItemView: View {
    
    // MARK: - Public Properties
    var station: Station
    @Binding var isPresentedRoute: Bool
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(station.name).font(.lexendBody)
                Row(img: .location, text: station.address)
                Row(img: .clock, text: "Schedule: \(station.schedule)")
                
                HStack {
                    Row(img: .payment, text: "Pay with:")
                    Image(.mastercard)
                        .navBarSize()
                    Image(.applePay)
                        .navBarSize()
                }
                
                ScrollableFuelsStack(station: station)

                if isPresentedRoute {
                    DismissRouteBtn { isPresentedRoute = false }
                } else {
                    RouteBtn { isPresentedRoute = true }
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
