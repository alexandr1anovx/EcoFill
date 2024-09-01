import SwiftUI

struct ScrollableFuelsStack: View {
    let station: Station
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                FuelCell(type: .euroA95, price: station.euroA95)
                FuelCell(type: .euroDP, price: station.euroDP)
                FuelCell(type: .gas, price: station.gas)
            }
        }
        .scrollIndicators(.hidden)
        .shadow(radius: 10)
    }
}


