import SwiftUI

struct LocationsList: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var stationVM: StationViewModel
    
    private var selectedCityStations: [Station] {
        stationVM.stations.filter { $0.city == userVM.selectedCity.rawValue }
    }

    var body: some View {
        VStack {
            Picker("", selection: $userVM.selectedCity) {
                ForEach(City.allCases) { city in
                    Text(city.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top,10)
            .padding(15)

            List(selectedCityStations) { station in
                LocationCell(station: station)
            }
            .listStyle(.plain)
            .listRowSpacing(15)
        }
        .onAppear {
            updateSelectedCity()
        }
    }
}

extension LocationsList {
    private func updateSelectedCity() {
        if let cityString = userVM.currentUser?.city,
           let city = City(rawValue: cityString) {
            userVM.selectedCity = city
        }
    }
}
