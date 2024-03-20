//
//  MapUtilities.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.03.2024.
//

import Foundation
import MapKit


func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    let directionsRequest = MKDirections.Request()
    directionsRequest.transportType = .automobile
    directionsRequest.source = from
    directionsRequest.destination = to

    do {
        let directions = MKDirections(request: directionsRequest)
        let response = try await directions.calculate()
        return response.routes.first
    } catch {
        print("Error calculating directions: \(error)")
        return nil
    }
}

func calculateDistance(from: CLLocation, to: CLLocation) -> Measurement<UnitLength> {
  let distanceInMeters = from.distance(from: to)
  return Measurement(value: distanceInMeters, unit: .meters)
}
