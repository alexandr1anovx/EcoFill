//
//  ProductCell.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct ScrollableFuelsStack: View {
  
  let station: Station
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing:8) {
        FuelCell(fuel: "A-95 Euro:",
                 price: station.euroA95,
                 containerWidth: 180,
                 bgColor: Color.gradientBlackGreen)
        FuelCell(fuel: "ДП Euro:",
                 price: station.euroDP,
                 containerWidth: 170,
                 bgColor: Color.gradientRedOrange)
        FuelCell(fuel: "ГАЗ:",
                 price: station.gas,
                 containerWidth: 140,
                 bgColor: Color.gradientRedOrange)
      }
    }
    .scrollIndicators(.hidden)
    .shadow(radius: 6)
  }
}

#Preview {
  ScrollableFuelsStack(station: .testStation)
}

struct FuelCell: View {
  
  let fuel: String
  let price: Double
  let containerWidth: CGFloat
  let bgColor: LinearGradient
  
  var body: some View {
    RoundedRectangle(cornerRadius:8)
      .fill(bgColor)
      .frame(width: containerWidth, height: 40)
      .overlay {
        HStack(spacing:8) {
          Text(fuel)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white)
          PriceRectangle(price: price,
                         color: .defaultBlack)
        }
      }
  }
}

