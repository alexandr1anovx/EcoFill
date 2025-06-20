//
//  Map+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import MapKit
import SwiftUICore

// MARK: - MKCoordinateRegion

extension MKCoordinateRegion: @retroactive Equatable {
  public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
    if lhs.center.latitude == rhs.center.latitude &&
        lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta {
      return true
    } else {
      return false
    }
  }
  static let userRegion = MKCoordinateRegion(
    center: .userLocation,
    latitudinalMeters: 10000,
    longitudinalMeters: 10000)
}

// MARK: - CLLocationCoordinate2D

extension CLLocationCoordinate2D {
  static let userLocation = CLLocationCoordinate2D(
    latitude: 46.959843,
    longitude: 32.012848
  )
}

// MARK: - MKDirectionsTransportType

extension MKDirectionsTransportType: CaseIterable, Hashable {
  public static var allCases: [MKDirectionsTransportType] {
    return [.automobile, .walking]
  }
  
  var title: LocalizedStringKey {
    switch self {
    case .automobile: "Automobile"
    case .walking: "Walking"
    default: "Unknown"
    }
  }
  
  var iconName: String {
    switch self {
    case .automobile: "car"
    case .walking: "figure.walk"
    default: "questionmark"
    }
  }
}
