//
//  Service.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import Foundation

enum ServiceType: String {
    case support
}

struct Service: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let type: ServiceType
}

let services: [Service] = [
    Service(
        title: "Support",
        description: "Send a feedback about our service.",
        imageName: "24.square.fill",
        type: .support
    )
]

