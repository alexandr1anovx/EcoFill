//
//  TabBarItem.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import SwiftUI

enum Tab: Int, CaseIterable, Identifiable {
  case home = 0, map, settings
  
  var id: Int { self.hashValue }
  
  var title: LocalizedStringKey {
    switch self {
    case .home: "Home"
    case .map: "Map"
    case .settings: "Settings"
    }
  }
  
  var imageName: String {
    switch self {
    case .home: "house"
    case .map: "map"
    case .settings: "gear"
    }
  }
}
