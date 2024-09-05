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
                .font(.system(size: 15))
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.cmWhite)
            Text("\(price, specifier: "₴%.2f")")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .foregroundStyle(.accent)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gradientBlueBlack)
        )
    }
}
