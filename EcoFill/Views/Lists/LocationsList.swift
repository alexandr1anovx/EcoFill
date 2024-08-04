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
    
    // MARK: - Private Properties
    @State private var selectedIndex = 0
    private let cities = ["Kyiv", "Odesa", "Mykolaiv"]
    private var filteredStations: [Station] {
        firestoreVM.stations.filter { $0.city == cities[selectedIndex] }
    }
    // MARK: - body
    var body: some View {
        VStack {
            Picker("", selection: $selectedIndex) {
                ForEach(cities.indices, id: \.self) { index in
                    Text(cities[index])
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
            if let selectedCity = authenticationVM.currentUser?.city,
               let index = cities.firstIndex(of: selectedCity) {
                selectedIndex = index
            }
        }
    }
}
