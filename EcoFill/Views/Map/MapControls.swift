//
//  MapControls.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.03.2024.
//

import SwiftUI

struct MapControls: View {
  
  @Binding var isPresentedList: Bool
  @Binding var isPresentedMapStyle: Bool
  
  var body: some View {
    VStack(spacing: 10) {
      
      ControlItem(image: .map) { isPresentedMapStyle = true }
      ControlItem(image: .location) { isPresentedList = true }
    }
  }
}

struct ControlItem: View {
  
  var image: ImageResource
  var action: () -> Void?
  
  var body: some View {
    Button {
      action()
    } label: {
      Image(image)
        .defaultSize()
    }
    .buttonStyle(CustomButtonModifier(pouring: .cmSystem))
    .shadow(radius: 5)
  }
}

#Preview {
  MapControls(isPresentedList: .constant(false),
              isPresentedMapStyle: .constant(false))
}
