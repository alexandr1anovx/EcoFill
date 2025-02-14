import Foundation
import MapKit

struct Station: Decodable, Identifiable, Hashable {
  let id: String
  let city: String
  let euroA95: Double
  let euroDP: Double
  let gas: Double
  let latitude: Double
  let longitude: Double
  let schedule: String
  let street: String
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: latitude,
      longitude: longitude
    )
  }
}

extension Station {
  static let mockStation = Station(
    id: "mock",
    city: "Mock City",
    euroA95: 0.0,
    euroDP: 0.0,
    gas: 0.0,
    latitude: 0.0,
    longitude: 0.0,
    schedule: "08:00-20:00",
    street: "Soborna Street"
  )
}
