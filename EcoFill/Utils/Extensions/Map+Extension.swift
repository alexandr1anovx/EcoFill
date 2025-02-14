//
//  Map+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import Foundation
import MapKit

// MARK: MKCoordinateRegion
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

// MARK: CLLocationCoordinate2D
extension CLLocationCoordinate2D {
  static let userLocation = CLLocationCoordinate2D(
    latitude: 46.959843,
    longitude: 32.012848
  )
}
