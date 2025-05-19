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
