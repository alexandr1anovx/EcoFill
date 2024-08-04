//
//  User.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 05.12.2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let city: String
    let initials: String
    let email: String
}
