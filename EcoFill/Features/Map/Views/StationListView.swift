import SwiftUI

struct StationListView: View {
  @Bindable var viewModel: StationViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      SortMenuView(viewModel: viewModel)
      List(viewModel.sortedStations) { station in
        StationListCell(station: station)
      }
      .scrollContentBackground(.hidden)
      .listStyle(.plain)
      .listRowSpacing(10)
    }
  }
}

extension StationListView {
  struct SortMenuView: View {
    @Bindable var viewModel: StationViewModel
    var body: some View {
      Menu {
        
        Menu {
          Picker("Select a city", selection: $viewModel.selectedCity) {
            ForEach(City.allCases) { city in
              Text(city.rawValue).tag(city)
            }
          }
        } label: {
          Label("City", systemImage: "building.2")
        }
        
        Menu {
          Picker("Sort by", selection: $viewModel.sortType) {
            ForEach(viewModel.sortOptions, id: \.self) { option in
              Text(option.rawValue).tag(option)
            }
          }
        } label: {
          Label("Other options", systemImage: "arrow.up.arrow.down")
        }
        
      } label: {
        Image(systemName: "slider.horizontal.3")
          .imageScale(.large)
          .foregroundStyle(.primary)
          .padding(8)
          .background {
            RoundedRectangle(cornerRadius: 15)
              .fill(.thinMaterial)
              .shadow(radius: 2)
          }
      }
      .padding()
    }
  }
}

#Preview {
  StationListView(viewModel: StationViewModel.mockObject)
    .environment(MapViewModel.mockObject)
    .environment(StationViewModel.mockObject)
}
