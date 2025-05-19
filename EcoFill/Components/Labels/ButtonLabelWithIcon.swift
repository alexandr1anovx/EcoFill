//
//  ButtonLabelWithIcon.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.03.2025.
//

import SwiftUI

struct ButtonLabelWithIcon: View {

  let title: LocalizedStringKey
  let iconName: String
  let textColor: Color
  let pouring: Color
  let verticalSpace: CGFloat?
  
  init(
    title: LocalizedStringKey,
    iconName: String,
    textColor: Color,
    pouring: Color,
    verticalSpace: CGFloat? = 16
  ) {
    self.title = title
    self.iconName = iconName
    self.textColor = textColor
    self.pouring = pouring
    self.verticalSpace = verticalSpace
  }
  
  var body: some View {
    Label(title, systemImage: iconName)
      .font(.subheadline)
      .fontWeight(.semibold)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical,verticalSpace)
      .background(pouring)
      .clipShape(.rect(cornerRadius: 15))
      .shadow(radius: 1)
  }
}

#Preview {
  ButtonLabelWithIcon(
    title: "Continue",
    iconName: "arrow.right.circle.fill",
    textColor: .white,
    pouring: .green
  )
}
