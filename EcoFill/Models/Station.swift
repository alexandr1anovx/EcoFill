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
  let name: String
  let postalCode: String
  let schedule: String
  let street: String
  
  var address: String {
    "\(street), \(postalCode)"
  }
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: latitude,
      longitude: longitude
    )
  }
}

extension Station {
  static let emptyStation = Station(
    id: "empty",
    city: "None",
    euroA95: 0.0,
    euroDP: 0.0,
    gas: 0.0,
    latitude: 0.0,
    longitude: 0.0,
    name: "None",
    postalCode: "None",
    schedule: "None",
    street: "None"
  )
}
