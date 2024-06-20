//
//  TestPicker.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.02.2024.
//

import SwiftUI

struct LocationsList: View {
  
  // MARK: - properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  @State private var selectedIndex = 0
  @Binding var selectedStation: Station?
  @Binding var isShownStationDetails: Bool
  @Binding var isShownRoute: Bool
  
  let cities = ["Kyiv", "Odesa", "Mykolaiv"]
  
  var filteredStations: [Station] {
    firestoreVM.stations.filter { $0.city == cities[selectedIndex] }
  }
  
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
        
        let isShownRouteCondition = selectedStation == station && isShownRoute
        
        StationCell(station: station, isShownRoute: isShownRouteCondition) {
          
          isShownStationDetails = false
          
          if isShownRouteCondition {
            selectedStation = nil
            isShownRoute = false
            
          } else {
            selectedStation = station
            isShownRoute = true
            
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
