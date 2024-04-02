//
//  ResetEmailBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.04.2024.
//

import SwiftUI

struct ResetBtn: View {
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(.checkmark)
          .resizable()
          .frame(width: 20, height: 20)
        Text("Reset")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    .shadow(radius: 5)
  }
}

#Preview {
  ResetBtn(action: {})
}
