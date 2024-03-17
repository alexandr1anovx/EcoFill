//
//  ProductCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ScrollableFuelsStack: View {
  
  // MARK: - Properties
  let station: Station
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 10) {
        FuelCell(fuel: "A-95 Euro",
                 price: station.euroA95,
                 width: 150,
                 pouring: Color.grBlueBlack)
        FuelCell(fuel: "DP Euro",
                 price: station.euroDP,
                 width: 140,
                 pouring: Color.grGreenBlack)
        FuelCell(fuel: "Gas",
                 price: station.gas,
                 width: 105,
                 pouring: Color.grGreenBlack)
      }
      .frame(height: 50)
    }
    .scrollIndicators(.hidden)
    .shadow(radius: 7)
  }
}

#Preview {
  ScrollableFuelsStack(station: .testStation)
}
