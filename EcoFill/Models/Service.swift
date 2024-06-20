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
  var id = UUID()
  var title: String
  var description: String
  var imageName: String
  var type: ServiceType
}

let services: [Service] = [
  Service(title: "Support",
          description: "Send a feedback about our service.",
          imageName: "24.square.fill",
          type: .support)
]

