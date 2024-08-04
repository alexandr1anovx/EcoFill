//
//  Cities.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 22.03.2024.
//

import Foundation

enum City: String, Identifiable, CaseIterable {
    case kyiv = "Kyiv"
    case mykolaiv = "Mykolaiv"
    case odesa = "Odesa"
    
    var id: Self { self }
}
