//
//  ButtonLabelWithIcon.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.03.2025.
//

import SwiftUI

struct ButtonLabelWithIcon: View {
  
  let title: String
  let iconName: String
  let textColor: Color
  let pouring: Color
  
  init(
    _ title: String,
    icon: String,
    textColor: Color,
    pouring: Color
  ) {
    self.title = title
    self.iconName = icon
    self.textColor = textColor
    self.pouring = pouring
  }
  
  var body: some View {
    Label(title, systemImage: iconName)
      .font(.subheadline)
      .fontWeight(.semibold)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      .background(pouring)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal, 20)
      .shadow(radius: 1)
  }
}

#Preview {
  ButtonLabelWithIcon(
    "Continue",
    icon: "arrow.right.circle.fill",
    textColor: .white,
    pouring: .green
  )
}
