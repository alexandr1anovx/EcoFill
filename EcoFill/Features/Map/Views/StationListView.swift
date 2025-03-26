import SwiftUI

struct StationListView: View {
  @EnvironmentObject var userVM: UserViewModel
  @EnvironmentObject var stationVM: StationViewModel
  
  private var selectedCityStations: [Station] {
    stationVM.stations.filter {
      $0.city == userVM.selectedCity.title
    }
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing:8) {
        Picker("", selection: $userVM.selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.title)
          }
        }
        .pickerStyle(.segmented)
        .padding(.top, 25)
        .padding(.horizontal, 20)
        List(selectedCityStations) { station in
          StationListCell(station: station)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 1)
      }
    }
    .onAppear {
      displaySelectedCity()
      setupPickerAppearance()
    }
  }
  
  // MARK: - UI Setup Methods
  private func displaySelectedCity() {
    if let cityString = userVM.currentUser?.city,
       let city = City(rawValue: cityString) {
      userVM.selectedCity = city
    }
  }
  private func setupPickerAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .buttonBackground
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.primaryText], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    appearance.backgroundColor = .systemBackground
  }
}

#Preview {
  StationListView()
    .environmentObject(UserViewModel())
    .environmentObject(StationViewModel())
}
