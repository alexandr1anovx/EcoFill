//
//  LoginButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.02.2024.
//

import SwiftUI

struct CustomButton: View {
  
  // MARK: - Properties
  var title: String
  var bgColor: Color
  var action: () -> Void
  
  // MARK: - body
  var body: some View {
    Button(title) {
      action()
    }
    .fontWeight(.medium)
    .foregroundStyle(.white)
    .frame(width: 130, height: 45)
    .background(bgColor)
    .clipShape(.buttonBorder)
    .shadow(radius: 5)
  }
}

#Preview {
  CustomButton(title: "Sign In", bgColor: .accent, action: {})
}
