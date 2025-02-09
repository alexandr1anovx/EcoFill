import SwiftUI

enum FuelType: String {
  case euroA95 = "A-95 Euro"
  case euroDP = "DP Euro"
  case gas = "Gas"
}

struct CustomFuelCell: View {
  let type: FuelType
  let price: Double
  
  var body: some View {
    HStack(spacing: 15) {
      Text(type.rawValue)
        .font(.poppins(.medium, size: 15))
        .foregroundStyle(.primaryWhite)
      
      Text("\(price, specifier: "₴%.2f")")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.orange)
    }
    .padding(13)
    .background(.primaryBlue)
    .clipShape(.rect(cornerRadius: 10))
  }
}

#Preview {
  CustomFuelCell(type: .euroA95, price: 50.4)
}
