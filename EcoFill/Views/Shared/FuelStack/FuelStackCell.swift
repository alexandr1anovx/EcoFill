import SwiftUI

enum FuelType: String {
  case euroA95 = "A-95 Euro"
  case euroDP = "DP Euro"
  case gas = "Gas"
}

struct FuelStackCell: View {
  let type: FuelType
  let price: Double
  
  var body: some View {
    HStack(spacing: 12) {
      Text(type.rawValue)
        .font(.callout)
        .fontWeight(.bold)
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
      Text("\(price, specifier: "₴%.2f")")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.green)
    }
    .padding(14)
    .background(.black)
    .clipShape(.rect(cornerRadius: 12))
  }
}

#Preview {
  FuelStackCell(type: .euroA95, price: 50.4)
}
