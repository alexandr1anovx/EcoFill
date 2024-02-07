//
//  ProductsViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.01.2024.
//

import Foundation
import FirebaseFirestore

class FirestoreDataViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var products: [Product] = []
  @Published var stations: [Station] = []
  
  // Database initialization
  private var db = Firestore.firestore()
  
  func fetchProductsData() {
    db.collection("products").addSnapshotListener { snapshot, error in
      // Check if documents in firebase is not empty
      guard let documents = snapshot?.documents else { return }
      
      // Convert of 'documentSnapshot' object to 'Product' object
      self.products = documents.map { documentSnapshot -> Product in
        let data = documentSnapshot.data()
        
        let title = data["title"] as? String ?? ""
        let description = data["description"] as? String ?? ""
        let price = data["price"] as? Double ?? 0.0
        
        return Product(id: .init(), title: title, description: description, price: price)
      }
    }
  }
  
  func fetchStationsData() {
    db.collection("stations").addSnapshotListener { snapshot, error in
      // Check if documents in firebase is not empty
      guard let documents = snapshot?.documents else { return }
      
      // Convert of 'documentSnapshot' object to 'Location' object
      self.stations = documents.map { documentSnapshot -> Station in
        let data = documentSnapshot.data()
        
        let city = data["city"] as? String ?? ""
        let country = data["country"] as? String ?? ""
        let latitude = data["latitude"] as? Double ?? 0.0
        let longitude = data["longitude"] as? Double ?? 0.0
        let name = data["name"] as? String ?? ""
        let schedule = data["schedule"] as? String ?? ""
        let street = data["street"] as? String ?? ""
        
        return Station(id: .init(),
                       name: name,
                       street: street,
                       city: city,
                       country: country,
                       schedule: schedule,
                       latitude: latitude,
                       longitude: longitude)
      }
    }
  }
}
