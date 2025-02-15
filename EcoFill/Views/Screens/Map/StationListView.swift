import SwiftUI

struct StationListView: View {
  
  @EnvironmentObject var userVM: UserViewModel
  @EnvironmentObject var stationVM: StationViewModel
  
  private var stationsInSelectedCity: [Station] {
    stationVM.stations.filter {
      $0.city == userVM.selectedCity.title
    }
  }
  
  // Picker Style Customization
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .accent
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .systemBackground
  }
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      
      VStack(spacing: 0) {
        cityPicker
          .padding(.top, 25)
          .padding(.horizontal, 20)
        
        List(stationsInSelectedCity) { station in
          StationListCell(station: station)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 3)
        .padding(.top, 5)
      }
    }
    .onAppear {
      displaySelectedCity()
    }
  }
  
  private var cityPicker: some View {
    Picker("", selection: $userVM.selectedCity) {
      ForEach(City.allCases) { city in
        Text(city.title)
      }
    }.pickerStyle(.segmented)
  }
  
  // MARK: - Logic Methods
  private func displaySelectedCity() {
    if let cityString = userVM.currentUser?.city,
       let city = City(rawValue: cityString) {
      userVM.selectedCity = city
    }
  }
}

#Preview {
  StationListView()
    .environmentObject( UserViewModel() )
    .environmentObject( StationViewModel() )
}
