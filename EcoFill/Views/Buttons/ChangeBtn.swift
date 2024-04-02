//
//  ChangePasswordBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 23.03.2024.
//

import SwiftUI

struct ChangeBtn: View {
  var title: String
  var img: ImageResource
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(img)
          .defaultSize()
        Text("Change \(title)")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    .shadow(radius: 5)
  }
}

#Preview {
  ChangeBtn(title: "password", img: .password, action: {})
}
