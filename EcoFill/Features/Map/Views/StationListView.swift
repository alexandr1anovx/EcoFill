import SwiftUI

struct StationListView: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var stationViewModel: StationViewModel
  
  private var selectedCityStations: [Station] {
    stationViewModel.stations.filter {
      $0.city == authViewModel.userCity.rawValue.capitalized
    }
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:0) {
        Picker("", selection: $authViewModel.userCity) {
          ForEach(City.allCases) { city in
            Text(city.title)
          }
        }
        .tint(.primary)
        .pickerStyle(.menu)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.top)
        .padding(.trailing,20)
        List(selectedCityStations) { station in
          StationListCell(station: station)
            .listRowBackground(Color.white.opacity(0.1))
            .padding(.vertical,10)
        }
        .customListStyle(rowSpacing:20)
      }
    }
    .onAppear { getSelectedCity() }
  }
  
  // MARK: - UI Setup Methods
  
  private func getSelectedCity() {
    if let cityString = authViewModel.currentUser?.city,
       let city = City(rawValue: cityString) {
      authViewModel.userCity = city
    }
  }
}

#Preview {
  StationListView()
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
}
