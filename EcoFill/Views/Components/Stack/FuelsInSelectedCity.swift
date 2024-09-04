import SwiftUI

struct FuelsInSelectedCity: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    
    private var selectedCityStation: Station? {
        mapViewModel.stations.first { $0.city == userViewModel.currentUser?.city }
    }
    
    var body: some View {
        if mapViewModel.stations.isEmpty {
            ContentUnavailableView(
                "Server Error. Failed to load stations!",
                systemImage: "gear.badge.xmark",
                description: Text("Please, try again later!")
            )
        } else {
            FuelsStack(station: selectedCityStation ?? .emptyStation)
        }
    }
}
