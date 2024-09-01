import SwiftUI

struct FuelsList: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    
    private var stationsInSelectedCity: [Station] {
        mapViewModel.stations.filter { $0.city == userViewModel.currentUser?.city }
    }
    
    var body: some View {
        if mapViewModel.stations.isEmpty {
            ContentUnavailableView(
                "Server is not responding",
                systemImage: "gear.badge.xmark",
                description: Text("Please, try again later.")
            )
        } else {
            ForEach(stationsInSelectedCity.prefix(1), id: \.id) { station in
                ScrollableFuelsStack(station: station)
            }
        }
    }
}
