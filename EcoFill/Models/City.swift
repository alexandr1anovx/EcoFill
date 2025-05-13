//
//  City.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//

import SwiftUICore

enum City: String, Identifiable, CaseIterable {
  case kyiv
  case mykolaiv
  case odesa
  
  var id: Self { self }
  
  var title: LocalizedStringKey {
    switch self {
    case .kyiv: "Kyiv"
    case .mykolaiv: "Mykolaiv"
    case .odesa: "Odesa"
    }
  }
}
