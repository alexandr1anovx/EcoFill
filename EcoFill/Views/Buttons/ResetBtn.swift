//
//  ResetEmailBtn.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.04.2024.
//

import SwiftUI

struct ResetBtn: View {
  var img: ImageResource
  var data: String
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Image(img)
          .defaultSize()
        Text("Reset \(data)")
          .font(.lexendFootnote)
          .foregroundStyle(.white)
      }
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
    .shadow(radius: 5)
    
    
    
    
    
    
//    Button {
//      action()
//    } label: {
//      HStack {
//        Image(.cmCheckmark)
//          .resizable()
//          .frame(width: 20, height: 20)
//        Text("Reset")
//          .font(.lexendCallout)
//          .foregroundStyle(.white)
//      }
//    }
//    .buttonStyle(CustomButtonModifier(pouring: .cmBlack))
//    .shadow(radius: 5)
  }
}
