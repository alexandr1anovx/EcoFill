//
//  AnimatedButtonStyle.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 12.03.2024.
//

import SwiftUI

struct AnimatedButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed ? 0.5 : 1.0)
      .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
  }
}

extension ButtonStyle where Self == AnimatedButtonStyle {
  static var animated: Self { Self() }
}
