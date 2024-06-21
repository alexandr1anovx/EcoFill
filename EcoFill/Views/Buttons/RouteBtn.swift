//
//  GetDirectionsBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct RouteBtn: View {
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(.route)
          .defaultSize()
        Text("Route")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlue))
    .shadow(radius: 5)
  }
}
