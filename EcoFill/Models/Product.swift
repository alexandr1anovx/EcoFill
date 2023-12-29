//
//  Product.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import Foundation

struct Product: Decodable, Identifiable {
  let id: Int
  let title: String
  let description: String
  let price: Double
}
