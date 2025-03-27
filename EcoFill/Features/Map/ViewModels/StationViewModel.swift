//
//  StationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.03.2025.
//

import FirebaseFirestore

@MainActor final class StationViewModel: ObservableObject {
  
  // MARK: Properties
  
  @Published var stations: [Station] = []
  let stationCollection = Firestore.firestore().collection("stations")
  
  // MARK: Public Methods
  
  func getStations() {
    stationCollection.addSnapshotListener { snapshot, error in
      if let error {
        print(error.localizedDescription)
        return
      }
      
      guard let documents = snapshot?.documents else { return }
      
      self.stations = documents.map { snapshot -> Station in
        let data = snapshot.data()
        let id = snapshot.documentID
        let city = data["city"] as? String ?? ""
        let euroA95 = data["euroA95"] as? Double ?? 0.0
        let euroDP = data["euroDP"] as? Double ?? 0.0
        let gas = data["gas"] as? Double ?? 0.0
        let latitude = data["latitude"] as? Double ?? 0.0
        let longitude = data["longitude"] as? Double ?? 0.0
        let schedule = data["schedule"] as? String ?? ""
        let street = data["street"] as? String ?? ""
        
        return Station(
          id: id,
          city: city,
          euroA95: euroA95,
          euroDP: euroDP,
          gas: gas,
          latitude: latitude,
          longitude: longitude,
          schedule: schedule,
          street: street
        )
      }
    }
  }
}
