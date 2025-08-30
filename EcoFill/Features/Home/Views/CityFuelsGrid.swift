import SwiftUI

struct CityFuelsGrid: View {
  @Environment(StationViewModel.self) var stationViewModel
  @Environment(SessionManager.self) var sessionManager
  
  private var stationInSelectedCity: Station? {
    stationViewModel.stations.first {
      $0.city == sessionManager.currentUser?.city
    }
  }
  
  var body: some View {
    Group {
      if !stationViewModel.stations.isEmpty {
        FuelStackCompact(station: stationInSelectedCity ?? Station.mock)
      } else {
        Label("No gas stations data found", systemImage: "fuelpump.fill")
      }
    }
  }
}

