//
//  LocationManager.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.02.2024.
//

import Foundation
import MapKit

enum LocationError {
  case authorizationDenied
  case authorizationRestricted
  case unknownLocation
  case accessDenied
  case network
  case operationFailed
  
  var errorDescription: String? {
    switch self {
      
    case .authorizationDenied:
      return NSLocalizedString("Location access denied", comment: "")
    case .authorizationRestricted:
      return NSLocalizedString("Location access restricted", comment: "")
    case .unknownLocation:
      return NSLocalizedString("Unknown location", comment: "")
    case .accessDenied:
      return NSLocalizedString("Access denied", comment: "")
    case .network:
      return NSLocalizedString("Network failed", comment: "")
    case .operationFailed:
      return NSLocalizedString("Operation failed", comment: "")
    }
  }
}

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
  
  let manager = CLLocationManager()
  static let shared = LocationManager() // creating a Singleton
  var error: LocationError? = nil
  
  var region: MKCoordinateRegion = MKCoordinateRegion()
  
  private override init() {
    super.init()
    self.manager.delegate = self
  }
}

extension LocationManager {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    locations.last.map {
      region = MKCoordinateRegion(center: CLLocationCoordinate2D(
        latitude: $0.coordinate.latitude,
        longitude: $0.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                    longitudeDelta: 0.05))
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
      
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .restricted:
      print("Restricted")
    case .denied:
      print("Denied")
    case .authorizedAlways, .authorizedWhenInUse:
      manager.requestLocation()
    @unknown default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let clError = error as? CLError {
      switch clError.code {
      case .locationUnknown:
        self.error = .unknownLocation
      case .denied:
        self.error = .accessDenied
      case .network:
        self.error = .network
      @unknown default:
        self.error = .operationFailed
      }
    }
  }
}
