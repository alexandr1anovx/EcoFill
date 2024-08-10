import SwiftUI

struct ScrollableFuelsStack: View {
    
    // MARK: - Public Properties
    let station: Station
    
    // MARK: - body
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                FuelCell(
                    fuel: "A-95 Euro",
                    price: station.euroA95,
                    width: 150,
                    pouring: Color.gradientBlueBlack
                )
                FuelCell(
                    fuel: "DP Euro",
                    price: station.euroDP,
                    width: 140,
                    pouring: Color.gradientBlueBlack
                )
                FuelCell(
                    fuel: "Gas",
                    price: station.gas,
                    width: 105,
                    pouring: Color.gradientBlueBlack
                )
            }
            .frame(height: 50)
        }
        .scrollIndicators(.hidden)
        .shadow(radius: 7)
    }
}
