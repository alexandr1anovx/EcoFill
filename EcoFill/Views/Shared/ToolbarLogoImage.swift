//
//  ToolbarLogoImage.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.02.2025.
//

import SwiftUI

struct ToolbarLogoImage: View {
  var body: some View {
    Image(.logo)
      .resizable()
      .scaledToFit()
      .frame(width: 54, height: 54)
  }
}

#Preview {
  ToolbarLogoImage()
}
