//
//  ProductsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct FuelsList: View {
  
  // MARK: - properties
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  var selectedCity: String
  var filteredStations: [Station] {
    firestoreVM.stations.filter { $0.city == selectedCity }
  }
  
  var body: some View {
    VStack {
      if firestoreVM.stations.isEmpty {
        ContentUnavailableView("Server is not responding",
                               systemImage: "gear.badge.xmark",
                               description: Text("Please, try again later."))
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
