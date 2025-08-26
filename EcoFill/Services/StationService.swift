//
//  StationService.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.05.2025.
//

import FirebaseFirestore

protocol StationServiceProtocol {
  func fetchStationsData() async throws -> [Station]
}

final class StationService: StationServiceProtocol {
  
  private let db = Firestore.firestore()
  private let stationCollection = "stations"
  
  func fetchStationsData() async throws -> [Station] {
    let snapshot = try await db
      .collection(stationCollection)
      .getDocuments()
    let stations = try snapshot.documents.compactMap { document in
      try document.data(as: Station.self)
    }
    return stations
  }
}
