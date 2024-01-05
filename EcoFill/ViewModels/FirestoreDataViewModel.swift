//
//  ProductsViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.01.2024.
//

import Foundation
import FirebaseFirestore

class FirestoreDataViewModel: ObservableObject {
  @Published var products: [Product] = []
  @Published var locations: [Location] = []
  
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
  
  func fetchLocationsData() {
    db.collection("locations").addSnapshotListener { snapshot, error in
      // Check if documents in firebase is not empty
      guard let documents = snapshot?.documents else { return }
      
      // Convert of 'documentSnapshot' object to 'Location' object
      self.locations = documents.map { documentSnapshot -> Location in
        let data = documentSnapshot.data()

        let street = data["street"] as? String ?? ""
        let city = data["city"] as? String ?? ""
        let schedule = data["schedule"] as? String ?? ""
        
        return Location(id: .init(), street: street, city: city, schedule: schedule)
      }
    }
  }
}
