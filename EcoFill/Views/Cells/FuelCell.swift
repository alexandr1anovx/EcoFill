import SwiftUI

struct FuelCell: View {
    
    // MARK: - Public Properties
    let fuel: String
    let price: Double
    let width: CGFloat
    let pouring: LinearGradient
    
    // MARK: - body
    var body: some View {
        RoundedRectangle(cornerRadius: 11)
            .fill(pouring)
            .frame(width: width, height: 43)
            .overlay(alignment: .center) {
                HStack(spacing: 20) {
                    Text(fuel)
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
