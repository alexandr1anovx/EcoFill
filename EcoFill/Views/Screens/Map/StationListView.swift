import SwiftUI

struct StationListView: View {
  
  @EnvironmentObject var userVM: UserViewModel
  @EnvironmentObject var stationVM: StationViewModel
  
  private var stationsInSelectedCity: [Station] {
    stationVM.stations.filter { $0.city == userVM.selectedCity.rawValue }
  }
  
  var body: some View {
    ZStack {
      Color.primaryBlue.ignoresSafeArea()
      
      VStack {
        Picker("", selection: $userVM.selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        
        List(stationsInSelectedCity) { station in
          StationListCell(station: station)
            .listRowBackground(Color.primaryBackground)
        }
        .padding(.top, 15)
        .listStyle(.plain)
        .listRowSpacing(10)
      }
    }
    .onAppear {
      updateSelectedCity()
    }
  }
  private func updateSelectedCity() {
    if let cityString = userVM.currentUser?.city,
       let city = City(rawValue: cityString) {
      userVM.selectedCity = city
    }
  }
}
