//
//  Color+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 17.02.2024.
//

import Foundation
import SwiftUI

extension Color {
  static let grRedOrange = LinearGradient(colors: [.defaultRed, .defaultOrange],
                                                  startPoint: .leading,
                                                  endPoint: .trailing)
  static let grGreen = LinearGradient(colors: [.accent],
                                                 startPoint: .leading,
                                                 endPoint: .trailing)
}
