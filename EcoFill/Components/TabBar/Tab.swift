//
//  TabBarItem.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.10.2024.
//

import Foundation

enum Tab: Int, CaseIterable, Identifiable {
  case home = 0, map, profile
  
  var id: Int { self.hashValue }
  
  var title: String {
    switch self {
    case .home: "Home"
    case .map: "Map"
    case .profile: "Profile"
    }
  }
  
  var imageName: String {
    switch self {
    case .home: "house"
    case .map: "map"
    case .profile: "person"
    }
  }
}

