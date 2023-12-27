//
//  Color+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 07.12.2023.
//

import SwiftUI

extension Color {
  
  static let grGreenDarkBlue = LinearGradient(
    colors: [.customGreen, .customDarkBlue],
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
  
  static let grOrangeDarkBlue = LinearGradient(
    colors: [.customOrange, .customDarkBlue],
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
}
