import SwiftUI

struct CityFuelsView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var stationVM: StationViewModel
    
    private var stationInSelectedCity: Station? {
        stationVM.stations.first { $0.city == userVM.currentUser?.city }
    }
    
    var body: some View {
        if !stationVM.stations.isEmpty {
            FuelStack(for: stationInSelectedCity ?? .emptyStation)
        } else {
            ContentUnavailableView(
                "Failed to load stations",
                systemImage: "gear.badge.xmark",
                description: Text("Please, try again later.")
            )
        }
    }
}
