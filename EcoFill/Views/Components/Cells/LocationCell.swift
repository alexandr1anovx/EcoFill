import SwiftUI

struct LocationCell: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    let station: Station
    
    private var isShownRoute: Bool {
        mapViewModel.selectedStation == station && mapViewModel.isRouteShown
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
                    mapViewModel.isDetailsShown = false
                    mapViewModel.selectedStation = nil
                    mapViewModel.isRouteShown = false
                }
            } else {
                BaseButton("Route", .route, .cmBlue) {
                    mapViewModel.isDetailsShown = false
                    mapViewModel.selectedStation = station
                    mapViewModel.isRouteShown = true
                }
            }
        }
    }
}
