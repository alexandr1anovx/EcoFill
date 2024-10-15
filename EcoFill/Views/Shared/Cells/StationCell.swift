import SwiftUI

struct StationCell: View {
    
    @EnvironmentObject var stationVM: StationViewModel
    let station: Station
    
    private var isPresentedRoute: Bool {
        stationVM.selectedStation == station 
        && stationVM.isRouteShown
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.cmReversed)
                CustomRow(station.schedule, image: "clock")
            }
            
            Spacer()
            
            if isPresentedRoute {
                CustomBtn("Hide", image: "xmark", color: .red) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = nil
                    stationVM.isRouteShown = false
                }
            } else {
                CustomBtn("Route", image: "arrow.triangle.branch", color: .accent) {
                    stationVM.isDetailsShown = false
                    stationVM.selectedStation = station
                    stationVM.isRouteShown = true
                }
            }
        }
    }
}
