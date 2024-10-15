import SwiftUI

enum FuelType: String {
    case euroA95 = "A95 Euro"
    case euroDP = "DP Euro"
    case gas = "Gas"
}

struct FuelCell: View {
    let type: FuelType
    let price: Double
    
    var body: some View {
        HStack(spacing: 13) {
            Text(type.rawValue)
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.cmWhite)
            Text("\(price, specifier: "₴%.2f")")
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.accent)
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gradientBlueBlack)
        )
    }
}
