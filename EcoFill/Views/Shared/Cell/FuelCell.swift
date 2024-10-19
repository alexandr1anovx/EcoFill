import SwiftUI

enum FuelType: String {
    case euroA95 = "A-95"
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
                .foregroundStyle(.primaryWhite)
                
            Text("\(price, specifier: "₴%.2f")")
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.primaryTeal)
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryBlue.gradient)
        )
    }
}
