//
//  Product.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 04.12.2023.
//

import Foundation

struct Product: Decodable, Identifiable {
  var id = UUID()
  var title: String
  var description: String
  var price: Double
}
