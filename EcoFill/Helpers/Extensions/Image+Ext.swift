//
//  Image+Ext.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 11.03.2024.
//

import SwiftUI

extension Image {
  
  func navBarSize() -> some View {
    self
      .resizable()
      .frame(width: 32, height: 32)
  }
  
  func defaultSize() -> some View {
    self
      .resizable()
      .frame(width: 24, height: 24)
  }
}
