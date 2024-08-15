import Foundation
import MapKit

func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    let request = MKDirections.Request()
    request.transportType = .walking
    request.source = from
    request.destination = to
    
    do {
        let directions = MKDirections(request: request)
        let response = try await directions.calculate()
        let route = response.routes.first
        return route
    } catch {
        print("An error occurred while calculating directions: \(error)")
        return nil
    }
}

private func calculateDistance(from: CLLocation, to: CLLocation) -> Measurement<UnitLength> {
    let distanceInMeters = from.distance(from: to)
    return Measurement(value: distanceInMeters, unit: .meters)
}
