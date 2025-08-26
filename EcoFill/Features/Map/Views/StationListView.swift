import SwiftUI

struct StationListView: View {
  @Bindable var viewModel: StationViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      SortMenuView(viewModel: viewModel)
      
      List(viewModel.stationsInSelectedCity) { station in
        StationListCell(station: station)
          .padding()
          .background(.thinMaterial)
          .clipShape(.rect(cornerRadius: 18))
      }
      .scrollContentBackground(.hidden)
      .listStyle(.plain)
      .listRowSpacing(15)
    }
  }
}

#Preview {
  StationListView(viewModel: StationViewModel())
    .environment(MapViewModel.mockObject)
    .environment(StationViewModel.previewMode)
}

extension StationListView {
  struct SortMenuView: View {
    @Bindable var viewModel: StationViewModel
    var body: some View {
      Menu {
        Picker("Sort by", selection: $viewModel.sortType) {
          ForEach(viewModel.sortOptions, id: \.self) { option in
            Text(option.rawValue)
              .tag(option)
          }
        }
      } label: {
        Image(systemName: "gearshape")
          .imageScale(.large)
          .foregroundStyle(.primary)
          .padding(5)
          .background {
            RoundedRectangle(cornerRadius: 12)
              .fill(.thinMaterial)
              .shadow(radius: 3)
          }
      }
      .padding(.top, 20)
      .padding(.leading, 18)
      Menu {
        Picker("Sort by", selection: $viewModel.selectedCity) {
          ForEach(City.allCases, id: \.self) { city in
            Text(city.rawValue.capitalized).tag(city)
          }
        }
      } label: {
        Image(systemName: "gearshape")
          .imageScale(.large)
          .foregroundStyle(.primary)
          .padding(5)
          .background {
            RoundedRectangle(cornerRadius: 12)
              .fill(.thinMaterial)
              .shadow(radius: 3)
          }
      }
      .padding(.top, 20)
      .padding(.leading, 18)
    }
  }
}
