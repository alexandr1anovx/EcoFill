//
//  BackButton.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.10.2024.
//

import SwiftUI

struct ReturnButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Image(systemName: "arrowshape.left.circle.fill")
      .imageScale(.large)
      .foregroundStyle(.accent)
      .onTapGesture {
        dismiss()
      }
  }
}

#Preview {
  ReturnButton()
}
