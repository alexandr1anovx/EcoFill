import SwiftUI

struct StationListView: View {
  
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var stationViewModel: StationViewModel
  
  private let stations = StationViewModel.StationSortType.allCases
  private var selectedCityStations: [Station] {
    stationViewModel.sortedStations.filter {
      $0.city == authViewModel.userCity.rawValue.capitalized
    }
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:0) {
        cityPickerView
        sortOptionPickerView
        Divider()
        stationsView
      }
    }
    .onAppear { getSelectedCity() }
  }
  
  // MARK: - UI Components
  
  private var cityPickerView: some View {
    HStack(spacing:0) {
      Text("City:").foregroundStyle(.primary)
      Picker("", selection: $authViewModel.userCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }
    }
    .pickerStyle(.menu)
    .tint(.indigo)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.vertical,10)
    .padding(.leading,23)
  }
  
  private var sortOptionPickerView: some View {
    HStack(spacing:0) {
      Text("Sort by:").foregroundStyle(.primary)
      Picker("", selection: $stationViewModel.sortType) {
        ForEach(stations, id: \.self) { type in
          Text(type.rawValue)
            .tag(type)
        }
      }
    }
    .pickerStyle(.menu)
    .tint(.indigo)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading,23)
    .padding(.bottom)
  }
  
  private var stationsView: some View {
    List(selectedCityStations) { station in
      StationListCell(station: station)
        .listRowBackground(Color.white.opacity(0.1))
        .padding(.vertical, 10)
    }
    .customListStyle(rowSpacing: 20, indicators: .visible)
  }
  
  // MARK: - Logical Methods
  
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
