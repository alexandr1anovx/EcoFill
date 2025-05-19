//
//  StationService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.05.2025.
//

import Firebase

final class StationService: StationServiceProtocol {
  
  // MARK: - Private Properties
  
  private var listener: ListenerRegistration?
  private let database = Firestore.firestore()
  
  // MARK: - Deinit
  
  deinit { listener?.remove() }
  
  // MARK: - Methods
  
  func getStationsData(completion: @escaping (Result<[Station], Error>) -> Void) {
    listener?.remove()
    
    listener = database
      .collection("stations")
      .addSnapshotListener { snapshot, error in
        if let error {
          completion(.failure(error))
          return
        }
        guard let documents = snapshot?.documents else {
          completion(.failure(
            NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found."]))
          )
          return
        }
        let stations = documents.compactMap {
          try? $0.data(as: Station.self)
        }
        completion(.success(stations))
      }
  }
}
