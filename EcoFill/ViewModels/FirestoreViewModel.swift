//
//  ProductsViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.01.2024.
//

import Foundation
import FirebaseFirestore

@MainActor
class FirestoreViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var stations: [Station] = []
//  @Published var cities: [Station] = []
  let cities = ["Kyiv", "Mykolaiv", "Odesa"]
  
  private var firestoreDatabase = Firestore.firestore() // Database initialization
  
  func fetchStations() {
    firestoreDatabase.collection("stations").addSnapshotListener { snapshot, error in
      
      // Check if documents in firebase is not empty
      guard let documents = snapshot?.documents else { return }
      
      // Convert of 'documentSnapshot' object to 'Location' object
      self.stations = documents.map { documentSnapshot -> Station in
        let data = documentSnapshot.data()

        let city = data["city"] as? String ?? ""
        let euroA95 = data["euroA95"] as? Double ?? 0.0
        let euroDP = data["euroDP"] as? Double ?? 0.0
        let gas = data["gas"] as? Double ?? 0.0
        let latitude = data["latitude"] as? Double ?? 0.0
        let longitude = data["longitude"] as? Double ?? 0.0
        let name = data["name"] as? String ?? ""
        let postalCode = data["postalCode"] as? String ?? ""
        let schedule = data["schedule"] as? String ?? ""
        let street = data["street"] as? String ?? ""
        
        return Station(id: .init(),
                       city: city,
                       euroA95: euroA95,
                       euroDP: euroDP,
                       gas: gas,
                       latitude: latitude,
                       longitude: longitude,
                       name: name,
                       postalCode: postalCode,
                       schedule: schedule,
                       street: street)
      }
    }
  }
}
