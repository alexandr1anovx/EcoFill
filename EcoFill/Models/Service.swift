//
//  Service.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import Foundation

struct Service: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  let image: String
}

let services: [Service] = [
  Service(title: "Products",
          description: "Watch prices.",
          image: "fuelpump.circle.fill"),
  
  Service(title: "Support",
          description: "Send feedback to improve our service.",
          image: "24.square.fill"),
  
  Service(title: "Food", description: "Choose food to eat.", image: "fork.knife.circle.fill")
]

extension Service {
  enum ServiceType: String {
    case products = "Products"
    case support = "Support"
    case food = "Food"
  }
}
