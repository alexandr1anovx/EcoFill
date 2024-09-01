import Foundation

enum ServiceType: String {
    case support = "Support"
}

struct Service: Identifiable {
    let id = UUID()
    let image: String
    let type: ServiceType
    let description: String
}

extension Service {
    static let services: [Service] = [
        Service(
            image: "24.square.fill",
            type: .support,
            description: "Send a feedback about us."
        )
    ]
}
