//
//  FuelsStack.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.02.2024.
//

import SwiftUI

struct FuelsStack: View {
  var station: Station
  
  var body: some View {
    HStack(spacing:15) {
      FuelDetail(fuel: "A-95",
                 price: station.euroA95,
                 bgColor: .accent)
      
      FuelDetail(fuel: "ДП",
                 price: station.euroDP,
                 bgColor: .defaultOrange)
      
      FuelDetail(fuel: "ГАЗ", 
                 price: station.gas,
                 bgColor: .defaultLightBlue)
    }
    .shadow(radius:8)
  }
}

#Preview {
  FuelsStack(station: .testStation)
}

struct FuelDetail: View {
  // MARK: - Properties
  var fuel: String
  var price: Double
  var bgColor: Color
  
  // MARK: - body
  var body: some View {
    VStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(bgColor)
        .frame(width: 66,height: 38)
        .overlay {
          Text(fuel)
            .font(.headline)
            .foregroundStyle(.white)
        }
      CustomPriceRectangle(price: price, color: .defaultBlack)
        .padding(.top,-15)
        .shadow(radius:8)
    }
  }
}
