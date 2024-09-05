import SwiftUI

struct FuelsInSelectedCity: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var stationVM: StationViewModel
    
    private var selectedCityStation: Station? {
        stationVM.stations.first { $0.city == userVM.currentUser?.city }
    }
    
    var body: some View {
        if stationVM.stations.isEmpty {
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
