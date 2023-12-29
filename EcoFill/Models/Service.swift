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
          image: "fuelpump"),
  
  Service(title: "Feedback",
          description: "Send feedback to improve our service.",
          image: "message.badge")
]
