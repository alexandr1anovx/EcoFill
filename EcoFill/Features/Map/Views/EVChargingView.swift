//
//  EVChargingView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.08.2025.
//

import SwiftUI

struct EVChargingView: View {
  let info: EVInfo
  
  private var availableConnectors: Int {
    info.connectors.filter { $0.status.lowercased() == "available" }.count
  }
  private var hasFastCharge: Bool {
    info.connectors.contains { $0.powerKw >= 50 }
  }
  
  var body: some View {
    VStack(spacing: 15) {
      HStack(spacing: 60) {
        if let provider = info.provider {
          MapItemInfoBlock(icon: "network", title: "Network", value: provider)
        }
        MapItemInfoBlock(icon: "p.circle.fill", title: "Свободно", value: "\(availableConnectors) / \(info.connectors.count)")
        if hasFastCharge {
          MapItemInfoBlock(icon: "hare.fill", title: "Fast", value: "Есть")
        }
      }
      Divider()
      
      ForEach(info.connectors, id: \.self) { connector in
        HStack {
          Image(systemName: "ev.plug.ac.type.2.fill")
            .foregroundStyle(.primary)
          
          VStack(alignment: .leading) {
            Text(connector.type)
              .fontWeight(.bold)
            Text("\(connector.powerKw) кВт • \(String(format: "%.2f", connector.pricePerKwh)) грн/кВтч")
              .font(.caption)
              .foregroundStyle(.secondary)
          }
          
          Spacer()
          
          Text(connector.status.capitalized)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(connector.status.lowercased() == "available" ? .green : .orange)
            .padding(7)
            .background(Color(.systemGray5))
            .clipShape(.capsule)
        }
        .padding(.bottom, 5)
      }
    }
    .padding()
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 20))
  }
}
