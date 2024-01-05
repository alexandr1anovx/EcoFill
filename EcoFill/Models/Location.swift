//
//  Location.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import Foundation

struct Location: Decodable, Identifiable {
  var id = UUID()
  var street: String
  var city: String
  var schedule: String
}
