import Foundation

struct User: Identifiable, Codable {
  let id: String
  let fullName: String
  let email: String
  let city: String
  let points: Int
}
