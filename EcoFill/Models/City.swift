//
//  City.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//

import SwiftUICore

enum City: String, Identifiable, CaseIterable {
  case kyiv = "Kyiv"
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
  
  var id: String { self.rawValue }
}
