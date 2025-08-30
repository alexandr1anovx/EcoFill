//
//  TabBarItem.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

enum Tab: Int, CaseIterable, Identifiable {
  case home = 0, map, more
  
  var id: Int { self.hashValue }
  
  var title: LocalizedStringKey {
    switch self {
    case .home: "Home"
    case .map: "Map"
    case .more: "More"
    }
  }
  
  var iconName: String {
    switch self {
    case .home: "house"
    case .map: "map"
    case .more: "water.waves"
    }
  }
}
