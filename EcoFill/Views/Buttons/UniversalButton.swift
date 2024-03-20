//
//  CustomButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 20.03.2024.
//

import SwiftUI

struct UniversalButton: View {
  
  var image: ImageResource
  var title: String
  var titleColor: Color
  var spacing: CGFloat
  var action: () -> Void?
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack(spacing: spacing) {
        Image(image)
          .defaultSize()
        Text(title)
          .font(.lexendCallout)
          .foregroundStyle(titleColor)
      }
    }
  }
}
