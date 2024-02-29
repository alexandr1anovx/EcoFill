//
//  User.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 05.12.2023.
//

import Foundation

struct User: Identifiable, Codable {
  var id: String
  var fullName: String
  var email: String
  var city: String
}
