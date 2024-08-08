//
//  TestPicker.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.02.2024.
//

import SwiftUI

struct LocationsList: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    @EnvironmentObject var firestoreVM: FirestoreViewModel
    @Binding var selectedStation: Station?
    @Binding var isPresentedStationDetails: Bool
    @Binding var isPresentedRoute: Bool
    let cities: [City] = City.allCases
    
    // MARK: - Private Properties
    @State private var selectedCity: City = .mykolaiv
    private var filteredStations: [Station] {
        firestoreVM.stations.filter {
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
        
        // which city is selected by the user, and find its index in the cities array.
        .onAppear {
            if let selectedCityString = authenticationVM.currentUser?.city,
               let city = City(rawValue: selectedCityString) {
                selectedCity = city
            }
        }
    }
}
