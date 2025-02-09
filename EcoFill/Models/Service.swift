import Foundation

enum ServiceType: String {
  case support
}

struct Service: Identifiable {
  let id = UUID()
  let image: String
  let type: ServiceType
  let description: String
  
  static let services: [Service] = [
    Service(
      image: "feedback",
      type: .support,
      description: "Send a feedback about us."
    )
  ]
}
