//
//  ButtonLabel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.03.2025.
//

import SwiftUI

struct ButtonLabel: View {
  
  let title: LocalizedStringKey
  let textColor: Color
  let pouring: Color
  let verticalSpace: CGFloat?
  
  init(
    title: LocalizedStringKey,
    textColor: Color,
    pouring: Color,
    verticalSpace: CGFloat? = 16
  ) {
    self.title = title
    self.textColor = textColor
    self.pouring = pouring
    self.verticalSpace = verticalSpace
  }
  
  var body: some View {
    Text(title)
      .font(.subheadline)
      .fontWeight(.medium)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical,verticalSpace)
      .background(pouring)
      .clipShape(.rect(cornerRadius: 15))
      .shadow(radius: 1)
  }
}

#Preview {
  ButtonLabel(
    title: "Continue",
    textColor: .white,
    pouring: .green
  )
}
