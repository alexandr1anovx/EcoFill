import SwiftUI

enum FuelType: String {
  case euroA95
  case euroDP
  case gas
  
  var title: String {
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
    HStack(spacing: 10) {
      Text(type.title)
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text("\(price, specifier: "₴%.2f")")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.primaryLime)
    }
    .padding(14)
    .background(.buttonBackground)
    .clipShape(.rect(cornerRadius: 15))
  }
}

#Preview {
  FuelStackCell(type: .euroA95, price: 50.4)
}

