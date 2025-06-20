import SwiftUI

struct StationListView: View {
  
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var stationViewModel: StationViewModel
  @State private var selectedCity: City = .mykolaiv
  
  private let sortingOptions = StationViewModel.StationSortType.allCases
  private var selectedCityStations: [Station] {
    stationViewModel.sortedStations.filter {
      $0.city == selectedCity.rawValue
    }
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:0) {
        sortingOptionsView
        stationsListView
      }
    }
  }
  
  // MARK: - Subviews
  private var sortingOptionsView: some View {
    List {
      Picker("City:", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue.capitalized).tag(city)
        }
      }
      Picker("Sort by:", selection: $stationViewModel.sortType) {
        ForEach(sortingOptions, id: \.self) { option in
          Text(option.rawValue).tag(option)
        }
      }
    }
    .customListStyle(
      scrollDisabled: true,
      indicators: .hidden,
      height: 150,
      shadow: 1
    )
  }
  
  private var stationsListView: some View {
    List(selectedCityStations) { station in
      StationListCell(station: station)
        .padding(.vertical, 10)
    }
    .customListStyle(
      rowSpacing: 20,
      indicators: .visible,
      shadow: 1
    )
  }
}

#Preview {
  StationListView()
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
}
