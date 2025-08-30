//
//  Station2.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 26.08.2025.
//

import FirebaseFirestore
import MapKit

struct Station: Codable, Identifiable, Hashable {
  @DocumentID var id: String?
  let uid: String
  let city: String
  let street: String
  let latitude: Double
  let longitude: Double
  let schedule: String
  let paymentMethods: [String]
  let stationType: StationType
  
  let fuelInfo: FuelInfo?
  let evInfo: EVInfo?
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

struct FuelInfo: Codable, Hashable {
  let euroA95: Double?
  let euroDP: Double?
  let gas: Double?
}

struct EVInfo: Codable, Hashable {
  let provider: String?
  let connectors: [EVConnector]
}

struct EVConnector: Codable, Hashable {
  let type: String
  let powerKw: Int
  let pricePerKwh: Double
  let status: String
}

enum StationType: String, CaseIterable, Identifiable, Codable {
  case fuel = "Паливо"
  case ev = "Зарядка"
  
  var id: String { self.rawValue }
  
  var iconName: String {
    switch self {
    case .fuel: "fuelpump.fill"
    case .ev: "ev.charger.fill"
    }
  }
}

// MARK: - Mock Data

extension Station {
  static let mock = Station(
    uid: "1",
    city: "City",
    street: "Soborna",
    latitude: 46.95,
    longitude: 32.057,
    schedule: "00:00-24:00",
    paymentMethods: ["Cash", "Card"],
    stationType: StationType.ev,
    fuelInfo: .mock,
    evInfo: .mock
  )
}

extension FuelInfo {
  static let mock: FuelInfo = .init(euroA95: 50.3, euroDP: 49.5, gas: 29.5)
}
extension EVConnector {
  static let mock: EVConnector = .init(type: "Connector 1", powerKw: 24, pricePerKwh: 50, status: "available")
}
extension EVInfo {
  static let mock: EVInfo = .init(provider: "Provider", connectors: [.mock])
}
