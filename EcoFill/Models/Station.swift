import MapKit
import FirebaseFirestore

struct Station: Codable, Identifiable, Hashable {
  
  @DocumentID var id: String?
  let uid: String
  let city: String
  let euroA95: Double
  let euroDP: Double
  let gas: Double
  let latitude: Double
  let longitude: Double
  let street: String
  let schedule: String
  let paymentMethods: String
  
  init(
    uid: String,
    city: String,
    euroA95: Double,
    euroDP: Double,
    gas: Double,
    latitude: Double,
    longitude: Double,
    street: String,
    schedule: String,
    paymentMethods: String
  ) {
    self.id = uid
    self.uid = uid
    self.city = city
    self.euroA95 = euroA95
    self.euroDP = euroDP
    self.gas = gas
    self.latitude = latitude
    self.longitude = longitude
    self.street = street
    self.schedule = schedule
    self.paymentMethods = paymentMethods
  }
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: latitude,
      longitude: longitude
    )
  }
}
