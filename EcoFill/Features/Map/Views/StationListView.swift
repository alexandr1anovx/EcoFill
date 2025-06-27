import SwiftUI

struct StationListView: View {
  @EnvironmentObject var viewModel: StationViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(spacing:0) {
        sortingPickers
        stationsList
      }
    }
  }
  
  // MARK: - Subviews
  
  private var sortingPickers: some View {
    List {
      Picker("City:", selection: $viewModel.selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue.capitalized).tag(city)
        }
      }
      Picker("Sort by:", selection: $viewModel.sortType) {
        ForEach(viewModel.sortOptions, id: \.self) { option in
          Text(option.rawValue)
            .tag(option)
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
  
  private var stationsList: some View {
    List(viewModel.stationsInSelectedCity) { station in
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
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
}
