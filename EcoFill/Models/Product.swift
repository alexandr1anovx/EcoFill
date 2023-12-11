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

let testProducts: [Product] = [
  Product(id: 1, title: "A-95", description: "Тестовий опис A-95", price: 49.50),
  Product(id: 2, title: "A-92", description: "Тестовий опис A-92", price: 45.20)
]
