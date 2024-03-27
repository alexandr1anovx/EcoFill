//
//  TestPicker.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.02.2024.
//

import SwiftUI
import UIKit

struct LocationsList: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  @State private var selectedIndex = 0
  
  let cities = ["Kyiv", "Odesa", "Mykolaiv"]
  
  var filteredStations: [Station] {
    firestoreVM.stations.filter {
      $0.city == cities[selectedIndex]
    }
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
        StationCoordinatesCell(station: station)
      }
      .listStyle(.plain)
      .listRowSpacing(15)
    }
    .onAppear {
      firestoreVM.fetchStations()
      
      // Setup an index for selected city.
      if let selectedCity = authenticationVM.currentUser?.city,
         let index = cities.firstIndex(of: selectedCity) {
        selectedIndex = index
      }
    }
  }
}


#Preview {
  LocationsList()
    .environmentObject(FirestoreViewModel())
    .environmentObject(AuthenticationViewModel())
}
