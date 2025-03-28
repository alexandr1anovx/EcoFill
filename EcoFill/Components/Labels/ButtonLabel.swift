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
  
  init(
    _ title: LocalizedStringKey,
    textColor: Color,
    pouring: Color
  ) {
    self.title = title
    self.textColor = textColor
    self.pouring = pouring
  }
  
  var body: some View {
    Text(title)
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
  ButtonLabel(
    "Continue",
    textColor: .white,
    pouring: .green
  )
}
