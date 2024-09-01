import SwiftUI

struct LocationsList: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var selectedCity: City = .mykolaiv
    
    private var stationsInSelectedCity: [Station] {
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

            List(stationsInSelectedCity) { station in
                let isRouteShown = mapViewModel.selectedStation == station && mapViewModel.isRouteShown

                StationCell(station: station, isShownRoute: isRouteShown) {
                    mapViewModel.isShownStationData = false
                    if isRouteShown {
                        mapViewModel.selectedStation = nil
                        mapViewModel.isRouteShown = false
                    } else {
                        mapViewModel.selectedStation = station
                        mapViewModel.isRouteShown = true
                    }
                }
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
