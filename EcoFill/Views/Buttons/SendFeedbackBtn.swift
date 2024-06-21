//
//  SendFeedbackBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct SendFeedbackBtn: View {
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(.checkmark)
          .resizable()
          .frame(width: 20, height: 20)
        Text("Send feedback")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    .shadow(radius: 5)
  }
}
