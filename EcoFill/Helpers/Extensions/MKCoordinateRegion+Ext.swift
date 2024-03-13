//
//  MKCoordinateRegion+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.02.2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
  
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
