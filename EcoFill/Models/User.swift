import SwiftUI

struct User: Identifiable, Codable {
  let id: String
  let fullName: String
  let email: String
  let city: String
  
  var localizedCity: LocalizedStringKey {
    return LocalizedStringKey(city.capitalized)
  }
}
