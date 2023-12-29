//
//  User.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 05.12.2023.
//

import Foundation

struct User: Identifiable, Codable {
  let id: String
  let fullName: String
  let email: String
  let city: String
}

extension User {
  static var MOCK_User = User(id: NSUUID().uuidString,
                              fullName: "Alex Andrianov",
                              email: "an4lex@gmail.com",
                              city: "Kyiv")
}
