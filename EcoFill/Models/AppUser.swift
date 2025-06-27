import SwiftUI
import FirebaseFirestore

struct AppUser: Identifiable, Codable {
  @DocumentID var id: String?
  let uid: String
  var fullName: String
  var email: String
  var city: String
  
  init(
    uid: String,
    fullName: String,
    email: String,
    city: String
  ) {
    self.id = uid
    self.uid = uid
    self.fullName = fullName
    self.email = email
    self.city = city
  }
  
  var localizedCity: LocalizedStringKey {
    return LocalizedStringKey(city.capitalized)
  }
}
