import SwiftUI

enum FuelType {
  case euroA95, euroDP, gas
  
  var title: LocalizedStringKey {
    switch self {
    case .euroA95: "A-95 Euro"
    case .euroDP: "DP Euro"
    case .gas: "Gas"
    }
  }
}

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

#Preview {
  FuelStackCell(type: .euroA95, price: 50.4)
}
