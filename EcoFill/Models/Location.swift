//
//  Location.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import Foundation

struct Location: Decodable, Identifiable {
    let id: Int
    let street: String
    let city: String
}
