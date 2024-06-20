//
//  MapControls.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 09.03.2024.
//

import SwiftUI

struct MapControls: View {
  
  // MARK: - properties
  @Binding var isShownList: Bool
  @Binding var isShownMapStyle: Bool
  
  var body: some View {
    VStack(spacing: 10) {
      ControlItem(image: .map) { isShownMapStyle = true }
      ControlItem(image: .location) { isShownList = true }
    }
  }
}

struct ControlItem: View {
  
  // MARK: - properties
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
  MapControls(isShownList: .constant(false),
              isShownMapStyle: .constant(false))
}
