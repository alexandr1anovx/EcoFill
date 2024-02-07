//
//  LocationsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct StationsList: View {
  // MARK: - Properties
  @ObservedObject var dataViewModel: FirestoreDataViewModel = FirestoreDataViewModel()
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      if dataViewModel.stations.isEmpty {
        ContentUnavailableView("The list of locations is empty.",
                               systemImage: "mappin",
                               description: Text("Please, check your internet connection."))
      } else {
        List(dataViewModel.stations) { station in
          StationLocationCell(station: station)
        }
        .listRowSpacing(15)
        .listStyle(.plain)
//        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top,20)
      }
    }
    .onAppear {
      dataViewModel.fetchStationsData()
    }
  }
}

#Preview {
  StationsList()
}
