import SwiftUI

struct LocationCell: View {
    @EnvironmentObject var stationVM: StationViewModel
    let station: Station
    
    private var isShownRoute: Bool {
        stationVM.selectedStation == station && stationVM.isRouteShown
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.callout)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.cmReversed)
                Row(station.schedule, image: .clock)
            }
            Spacer()
            
            if isShownRoute {
                BaseButton("Hide Route", .route, .blue) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = nil
                    stationVM.isRouteShown = false
                }
            } else {
                BaseButton("Route", .route, .cmBlue) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = station
                    stationVM.isRouteShown = true
                }
            }
        }
    }
}
