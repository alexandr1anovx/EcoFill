//
//  ProductsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct FuelsList: View {
  
  // MARK: - Properties
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  var selectedCity: String
  
  var filteredStations: [Station] {
    firestoreVM.stations.filter { $0.city == selectedCity }
  }
  
  var body: some View {
    VStack {
      if firestoreVM.stations.isEmpty {
        ContentUnavailableView("Internet Connection Error",
                               systemImage: "wifi.slash",
                               description: Text("Please, refresh your internet."))
      } else {
        ForEach(filteredStations.prefix(1), id: \.id) { station in
          ScrollableFuelsStack(station: station)
        }
      }
    }
  }
}

#Preview {
  FuelsList(selectedCity: "Mykolaiv")
    .environmentObject(FirestoreViewModel())
}
