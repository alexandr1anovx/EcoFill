//
//  ProductsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import SwiftUI

struct FuelsList: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var firestoreVM: FirestoreViewModel
    let selectedCity: String
    
    // MARK: - Private Properties
    private var filteredStations: [Station] {
        firestoreVM.stations.filter { $0.city == selectedCity }
    }
    
    // MARK: - body
    var body: some View {
        VStack {
            if firestoreVM.stations.isEmpty {
                ContentUnavailableView(
                    "Server is not responding",
                    systemImage: "gear.badge.xmark",
                    description: Text("Please, try again later.")
                )
            } else {
                ForEach(filteredStations.prefix(1), id: \.id) { station in
                    ScrollableFuelsStack(station: station)
                }
            }
        }
    }
}
