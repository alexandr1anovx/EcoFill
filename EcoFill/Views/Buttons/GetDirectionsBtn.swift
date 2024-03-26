//
//  GetDirectionsBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct GetDirectionsBtn: View {
  var action: () -> Void
  
  var body: some View {
    Button {
      // action
    } label: {
      HStack {
        Image(.walkingBoy)
          .defaultSize()
        Text("Get directions")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    .shadow(radius: 5)
  }
}

#Preview {
  GetDirectionsBtn(action: {})
}
