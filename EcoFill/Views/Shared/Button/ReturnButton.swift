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
    Button {
      dismiss()
    } label: {
      Image(systemName: "arrow.backward.circle")
        .symbolVariant(.fill)
        .imageScale(.large)
        .foregroundStyle(.accent)
    }
    .buttonStyle(.animated)
  }
}

#Preview {
  ReturnButton()
  
}
