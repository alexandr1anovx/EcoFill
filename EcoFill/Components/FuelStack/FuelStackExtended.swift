//
//  FuelStackExtended.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.08.2025.
//

import SwiftUI

struct FuelStackExtended: View {
  let info: FuelInfo
  var body: some View {
    HStack(spacing: 50) {
      if let a95 = info.euroA95 {
        MapItemInfoBlock(
          icon: "fuelpump.fill",
          title: "A-95",
          value: String(format: "%.2f", a95)
        )
      }
      if let dp = info.euroDP {
        MapItemInfoBlock(
          icon: "fuelpump.fill",
          title: "Дизель",
          value: String(format: "%.2f", dp)
        )
      }
      if let gas = info.gas {
        MapItemInfoBlock(
          icon: "air.suv.side.fill",
          title: "Газ",
          value: String(format: "%.2f", gas)
        )
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 20))
  }
}

#Preview {
  FuelStackExtended(info: FuelInfo.mock)
}
