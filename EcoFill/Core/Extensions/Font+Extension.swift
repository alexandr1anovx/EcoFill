//
//  Font+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 06.12.2024.
//

import SwiftUI

extension Font {
  enum PoppinsFont {
    case regular, medium, bold
    
    var value: String {
      switch self {
      case .regular: "Poppins-Regular"
      case .medium: "Poppins-Medium"
      case .bold: "Poppins-Bold"
      }
    }
  }
  static func poppins(_ type: PoppinsFont, size: CGFloat = 20) -> Font {
    return .custom(type.value, size: size)
  }
}
