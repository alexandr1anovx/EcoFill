import SwiftUI

struct FuelsInSelectedStation: View {
    let station: Station
    
    init(_ station: Station) {
        self.station = station
    }
    
    var body: some View {
        FuelsStack(station: station)
    }
}
