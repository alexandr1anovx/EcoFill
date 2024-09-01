import SwiftUI

struct Fuel {
    enum FuelType: String {
        case euroA95 = "A95 Euro"
        case euroDP = "DP Euro"
        case gas = "Gas"
    }

    let type: FuelType
    let price: Double
}

struct FuelCell: View {
    let type: FuelType
    let price: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gradientBlueBlack)
            .frame(width: 140, height: 45)
            .overlay(alignment: .center) {
                HStack(spacing: 15) {
                    Text(type.rawValue)
                        .font(.lexendCallout)
                        .foregroundStyle(.cmWhite)
                    Text("\(price, specifier: "₴%.2f")")
                        .font(.lexendFootnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.accent)
                }
            }
    }
}


extension FuelCell {
    
}

