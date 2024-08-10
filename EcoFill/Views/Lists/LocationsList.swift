import SwiftUI

struct LocationsList: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var firestoreViewModel: FirestoreViewModel
    @Binding var selectedStation: Station?
    @Binding var isPresentedStationDetails: Bool
    @Binding var isPresentedRoute: Bool
    let cities: [City] = City.allCases
    
    // MARK: - Private Properties
    @State private var selectedCity: City = .mykolaiv
    private var filteredStations: [Station] {
        firestoreViewModel.stations.filter {
            $0.city == selectedCity.rawValue
        }
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            Picker("", selection: $selectedCity) {
                ForEach(cities) { city in
                    Text(city.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top,10)
            .padding(15)
            
            List(filteredStations) { station in
                let isShownRoute = selectedStation == station && isPresentedRoute
                
                StationCell(station: station, isShownRoute: isShownRoute) {
                    isPresentedStationDetails = false
                    if isShownRoute {
                        selectedStation = nil
                        isPresentedRoute = false
                    } else {
                        selectedStation = station
                        isPresentedRoute = true
                    }
                }
            }
            .listStyle(.plain)
            .listRowSpacing(15)
        }
        
        .onAppear {
            if let selectedCityString = authenticationViewModel.currentUser?.city,
               let city = City(rawValue: selectedCityString) {
                selectedCity = city
            }
        }
    }
}
