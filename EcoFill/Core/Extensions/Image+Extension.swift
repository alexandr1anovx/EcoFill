//
//  Image+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 15.02.2025.
//

import SwiftUI

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
