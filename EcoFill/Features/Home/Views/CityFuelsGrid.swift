import SwiftUI

struct CityFuelsGrid: View {
  @EnvironmentObject var viewModel: StationViewModel
  @EnvironmentObject var sessionManager: SessionManager
  
  private var stationInSelectedCity: Station? {
    viewModel.stations.first {
      $0.city == sessionManager.currentUser?.city
    }
  }
  
  var body: some View {
    if !viewModel.stations.isEmpty {
      FuelStackView(for: stationInSelectedCity ?? MockData.station)
    } else {
      ContentUnavailableView(
        "Failed to load gas stations data",
        systemImage: "gear.badge.xmark",
        description: Text("Please, try again later.")
      )
    }
  }
}

