import SwiftUI

struct LocationsList: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var selectedCity: City = .mykolaiv
    
    private var selectedCityStations: [Station] {
        mapViewModel.stations.filter { $0.city == selectedCity.rawValue }
    }

    var body: some View {
        VStack {
            Picker("", selection: $selectedCity) {
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
        if let cityString = userViewModel.currentUser?.city,
           let city = City(rawValue: cityString) {
            selectedCity = city
        }
    }
}
