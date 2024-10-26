import SwiftUI

struct FuelStackView: View {
    let station: Station
    
    init(for station: Station) {
        self.station = station
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                FuelCell(type: .euroA95, price: station.euroA95)
                FuelCell(type: .euroDP, price: station.euroDP)
                FuelCell(type: .gas, price: station.gas)
            }
        }
        .scrollIndicators(.hidden)
        .shadow(radius: 6)
    }
}
