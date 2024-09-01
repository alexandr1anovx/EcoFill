import Foundation

struct User: Identifiable, Codable {
    let id: String
    let city: String
    let email: String
    let initials: String
}
