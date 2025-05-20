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
    HStack(spacing:5) {
      Text("\(type.title):")
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text(price, format: .currency(code: "UAH"))
        .font(.poppins(.bold, size: 14))
        .foregroundStyle(.black)
    }
    .padding(13)
    .background(.accent)
    .clipShape(.rect(cornerRadius: 14))
  }
}

#Preview {
  FuelStackCell(type: .euroA95, price: 50.4)
}

