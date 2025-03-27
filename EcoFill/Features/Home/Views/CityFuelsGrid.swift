import SwiftUI

struct CityFuelsGrid: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var stationViewModel: StationViewModel
  
  private var stationInSelectedCity: Station? {
    stationViewModel.stations.first { $0.city == authViewModel.currentUser?.city }
  }
  
  var body: some View {
    if !stationViewModel.stations.isEmpty {
      FuelStackView(for: stationInSelectedCity ?? .mockStation)
    } else {
      ContentUnavailableView(
        "Failed to load gas stations data",
        systemImage: "gear.badge.xmark",
        description: Text("Please, try again later.")
      )
    }
  }
}

