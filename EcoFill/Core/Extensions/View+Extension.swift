//
//  View+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 16.10.2024.
//

import SwiftUI

// MARK: View
extension View {
  func buttonModifier(pouring: Color) -> some View {
    self.buttonStyle(CustomButtonStyle(with: pouring))
  }
}

// MARK: ButtonStyle
extension ButtonStyle where Self == AnimatedButtonStyle {
  static var animated: AnimatedButtonStyle {
    return AnimatedButtonStyle()
  }
}

// MARK: Image
extension Image {
  var navigationBarImageSize: some View {
    self
      .resizable()
      .frame(width: 28, height: 28)
  }
  var defaultImageSize: some View {
    self
      .resizable()
      .frame(width: 22, height: 22)
  }
}
