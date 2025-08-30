import SwiftUI

struct FuelStackCompact: View {
  @Environment(StationViewModel.self) var stationViewModel
  let station: Station
  
  private func price(for fuelType: FuelType) -> Double {
    switch fuelType {
    case .euroA95: station.fuelInfo?.euroA95 ?? 0.0
    case .euroDP: station.fuelInfo?.euroDP ?? 0.0
    case .gas: station.fuelInfo?.gas ?? 0.0
    }
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 10) {
        ForEach(FuelType.allCases, id: \.self) { fuel in
          FuelStackCell(type: fuel, price: price(for: fuel))
        }
      }
    }
    .scrollIndicators(.hidden)
    .shadow(radius: 2)
  }
}

#Preview {
  FuelStackCompact(station: Station.mock)
}

extension FuelStackCompact {
  struct FuelStackCell: View {
    let type: FuelType
    let price: Double
    
    var body: some View {
      HStack {
        Text(type.title)
          .font(.subheadline)
          .fontWeight(.bold)
        Text(price, format: .currency(code: "UAH"))
          .font(.poppins(.bold, size: 14))
          .foregroundStyle(.green)
      }
      .padding(14)
      .background(.thinMaterial)
      .clipShape(.rect(cornerRadius: 18))
    }
  }
  
  enum FuelType: LocalizedStringKey, CaseIterable {
    case euroA95, euroDP, gas
    
    var title: LocalizedStringKey {
      switch self {
      case .euroA95: "A-95 Euro"
      case .euroDP: "DP Euro"
      case .gas: "Gas"
      }
    }
  }
}
