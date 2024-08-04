//
//  ProductsViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.01.2024.
//

import Foundation
import FirebaseFirestore

final class FirestoreViewModel: ObservableObject {
    
    // MARK: - Public Properties
    @Published var stations: [Station] = []
    
    // MARK: - Private properties
    private let db = Firestore.firestore()
    
    // MARK: - Public Methods
    func fetchStations() {
        db.collection("stations").addSnapshotListener { snapshot, error in
            guard let error = error else { return }
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
                let name = data["name"] as? String ?? ""
                let postalCode = data["postalCode"] as? String ?? ""
                let schedule = data["schedule"] as? String ?? ""
                let street = data["street"] as? String ?? ""
                
                return Station(id: id,
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
